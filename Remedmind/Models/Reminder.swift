//
//  Reminder.swift
//  Remedmind
//
//  Created by Davide Aliti on 09/12/22.
//

import Foundation

struct ReminderModel: Identifiable {
    let id = UUID()
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
