//
//  AdministrationFrequency+Description.swift
//  Remedmind
//
//  Created by Davide Aliti on 03/06/23.
//

import Foundation

extension AdministrationFrequency {
    var administrationFrequencyDescription: String {
        switch self {
        case .daily: return String(localized: "administrationFrequency.daily")
        case .everyOtherDay: return String(localized: "administrationFrequency.everyOtherDay")
        case .weekly: return String(localized: "administrationFrequency.weekly")
        }
    }
}

