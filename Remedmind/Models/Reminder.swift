//
//  Reminder.swift
//  Remedmind
//
//  Created by Davide Aliti on 09/12/22.
//

import Foundation

struct ReminderModel: Identifiable {
    var id: UUID = UUID()
    var medicine: MedicineModel = MedicineModel()
    var image: String = ""
    var notes: String = ""
    var activeAdministrationNotification: Bool = false
    var administrationNotificationTimes: [Date] = []
    var activeRunningLowNotification: Bool = false
    var runningLowNotificationTime: Date = Date.now
    var startDate: Date = Date.now
    var endDate: Date = Date.distantFuture
}

extension ReminderModel {
    mutating func update(from reminder: Reminder) {
        self.id = reminder.id ?? UUID()
        self.image = reminder.image ?? ""
        self.notes = reminder.notes ?? ""
        self.startDate = reminder.startDate ?? Date.now
        self.activeAdministrationNotification = reminder.activeAdministrationNotification
        self.administrationNotificationTimes = reminder.administrationNotificationTimes ?? []
        self.activeRunningLowNotification =  reminder.activeRunningLowNotification
        self.runningLowNotificationTime = reminder.runningLowNotificationTime ?? Date.now
        self.endDate = reminder.endDate ?? Date.now
        self.medicine.update(from: reminder)
    }
}
