//
//  IntakeNotificationType+Description.swift
//  Remedmind
//
//  Created by Davide Aliti on 21/08/23.
//

import Foundation

extension IntakeNotificationType {
    var intakeNotificationTypeDescription: String {
        switch self {
        case .automatic: return String(localized: "intakeNotificationType.automatic")
        case .custom: return String(localized: "intakeNotificationType.custom")
        }
    }
}
