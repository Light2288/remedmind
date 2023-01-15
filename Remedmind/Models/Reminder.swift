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
    var activeRunningLowNotification: Bool = false
}
