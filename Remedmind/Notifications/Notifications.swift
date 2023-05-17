//
//  Notifications.swift
//  Remedmind
//
//  Created by Davide Aliti on 10/05/23.
//

import Foundation
import UserNotifications

class LocalNotifications {
    static var shared = LocalNotifications()
    
    var lastKnownPermission: UNAuthorizationStatus?
    var userNotificationCenter: UNUserNotificationCenter { UNUserNotificationCenter.current() }
    
    private init() {
        userNotificationCenter.getNotificationSettings { settings in
            let permission = settings.authorizationStatus
            
            switch permission {
#if os(iOS)
            case .ephemeral, .provisional: fallthrough
#endif
                
            case .notDetermined:
                self.requestLocalNotificationPermission(completion: { _ in })
                
            case .authorized, .denied:
                break
                
            @unknown default: break
            }
        }
    }
    
    func createNotificationDays(for reminder: Reminder) -> [Date] {
        let endDate = Calendar.customLocalizedCalendar.date(byAdding: .day, value: 7, to: Date.now)!
        return reminder.getFutureIntakeDates(to: endDate)
    }
    
    func createTriggers(for reminder: Reminder) -> [UNCalendarNotificationTrigger] {
        var triggers: [UNCalendarNotificationTrigger] = []
        let notificationDays = createNotificationDays(for: reminder)
        guard let administrationTimes = reminder.administrationNotificationTimes else { return [] }
        
        for notificationDay in notificationDays {
            for administrationTime in administrationTimes {
                var date = DateComponents()
                date.calendar = Calendar.customLocalizedCalendar
                date.year = Calendar.customLocalizedCalendar.component(.year, from: notificationDay)
                date.month = Calendar.customLocalizedCalendar.component(.month, from: notificationDay)
                date.day = Calendar.customLocalizedCalendar.component(.day, from: notificationDay)
                date.hour = Calendar.customLocalizedCalendar.component(.hour, from: administrationTime)
                date.minute = Calendar.customLocalizedCalendar.component(.minute, from: administrationTime)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
                triggers.append(trigger)
            }
        }
        
        return triggers
    }
    
    func getRequestIdentifiersToDelete(for reminder: Reminder, requests: [UNNotificationRequest]) -> [String] {
        return requests.filter { $0.content.userInfo["reminderId"] as? String == reminder.id?.uuidString }.map { $0.identifier }
    }
    
    func deleteDeliveredNotificationRequests(for reminder: Reminder, _ completion: @escaping (Reminder) -> Void) {
        var deliveredNotificationsIdentifiers: [String] = []
        userNotificationCenter.getDeliveredNotifications { [weak self] notifications in
            deliveredNotificationsIdentifiers.append(contentsOf: self?.getRequestIdentifiersToDelete(for: reminder, requests: notifications.map { $0.request }) ?? [])
            self?.userNotificationCenter.removeDeliveredNotifications(withIdentifiers: deliveredNotificationsIdentifiers)
            completion(reminder)
        }
    }
    
    func deletePendingNotificationRequests(for reminder: Reminder, _ completion: @escaping (Reminder) -> Void) {
        var pendingNotificationRequestsIdentifiers: [String] = []
        userNotificationCenter.getPendingNotificationRequests { [weak self] requests in
            pendingNotificationRequestsIdentifiers.append(contentsOf: self?.getRequestIdentifiersToDelete(for: reminder, requests: requests) ?? [])
            self?.userNotificationCenter.removePendingNotificationRequests(withIdentifiers: pendingNotificationRequestsIdentifiers)
            completion(reminder)
        }
    }
    
    func deleteAllNotificationRequests(for reminder: Reminder, _ completion: @escaping (Reminder) -> Void) {
        deleteDeliveredNotificationRequests(for: reminder) { reminder in
            self.deletePendingNotificationRequests(for: reminder) { reminder in
                completion(reminder)
            }
        }
    }
    
    func createNotificationRequests(for reminder: Reminder) {
        userNotificationCenter.getNotificationSettings { settings in
            let content = UNMutableNotificationContent()
            content.title = "Remedmind"
                        content.body = "Remember to register your intake for \(reminder.medicineName ?? "unknown medicine")"
            content.userInfo = ["reminderId": reminder.id?.uuidString as Any]
            
            if settings.soundSetting == .enabled {
                content.sound = UNNotificationSound.default
            }
            
            let triggers = self.createTriggers(for: reminder)
            
            for trigger in triggers {
                let notificationRequest = UNNotificationRequest(
                    identifier: UUID().uuidString,
                    content: content,
                    trigger: trigger
                )
                self.userNotificationCenter.add(notificationRequest)
            }
        }
    }
    
    func deleteAndCreateNewNotificationRequests(for reminder: Reminder) {
        deleteAllNotificationRequests(for: reminder) { reminder in
            self.createNotificationRequests(for: reminder)
        }
    }

func requestLocalNotificationPermission(completion: @escaping (_ granted: Bool) -> Void) {
    let options: UNAuthorizationOptions = [.alert, .sound]
    
    userNotificationCenter.requestAuthorization(options: options) { granted, error in
        DispatchQueue.main.async {
            if let error = error {
                print(error)
                completion(false)
                return
            }
            
            guard granted else {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
}
}
