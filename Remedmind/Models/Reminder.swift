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
    var administrationNotificationTimes: [Date] = [Date.now]
    var activeRunningLowNotification: Bool = false
    var runningLowNotificationTime: Date = Date.now
    var startDate: Date = Date.now
    var endDate: Date = Date.distantFuture
}

extension ReminderModel {
    mutating func update(from reminder: Reminder) {
        self.id = reminder.id
        self.image = reminder.image
        self.notes = reminder.notes
        self.startDate = reminder.startDate
        self.activeAdministrationNotification = reminder.activeAdministrationNotification
        self.administrationNotificationTimes = reminder.administrationNotificationTimes
        self.activeRunningLowNotification =  reminder.activeRunningLowNotification
        self.runningLowNotificationTime = reminder.runningLowNotificationTime
        self.endDate = reminder.endDate
        self.medicine.update(from: reminder)
    }
}
