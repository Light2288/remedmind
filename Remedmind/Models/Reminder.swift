//
//  Reminder.swift
//  Remedmind
//
//  Created by Davide Aliti on 09/12/22.
//

import Foundation

struct Reminder {
    var medicine: Medicine = Medicine()
    var activeAdministrationNotification: Bool = false
    var activeRunningLowNotification: Bool = false
}
