//
//  AdministrationType+Description.swift
//  Remedmind
//
//  Created by Davide Aliti on 07/06/23.
//

import Foundation

extension AdministrationType{
    var administrationTypeDescription: String {
        switch self {
        case .pill:
            return String(localized: "administrationType.pill")
        case .sachet:
            return String(localized: "administrationType.sachet")
        case .drop:
            return String(localized: "administrationType.drop")
        case .other:
            return String(localized: "administrationType.other")
        }
    }
    
    var administrationTypeDescriptionPlural: String {
        switch self {
        case .pill:
            return String(localized: "administrationType.pills")
        case .sachet:
            return String(localized: "administrationType.sachets")
        case .drop:
            return String(localized: "administrationType.drops")
        case .other:
            return String(localized: "administrationType.other")
        }
    }
}
