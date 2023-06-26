//
//  AdministrationType+Description.swift
//  Remedmind
//
//  Created by Davide Aliti on 07/06/23.
//

import Foundation

extension AdministrationType {
    var hasIntakeQuantity: Bool {
        switch self {
        case .capsule, .tablet, .sachet, .drop, .suppository, .patch:
            return true
        default :
            return false
        }
    }
    
    var canRunLow: Bool {
        switch self {
        case .capsule, .tablet, .sachet, .suppository, .patch:
            return true
        default :
            return false
        }
    }
    
    var administrationTypeShortDescription: String {
        switch self {
        case .capsule:
            return String(localized: "administrationType.capsule")
        case .tablet:
            return String(localized: "administrationType.tablet")
        case .sachet:
            return String(localized: "administrationType.sachet")
        case .drop:
            return String(localized: "administrationType.drop")
        case .suppository:
            return String(localized: "administrationType.suppository")
        case .patch:
            return String(localized: "administrationType.patch")
        case .cream:
            return String(localized: "administrationType.cream")
        case .liquid:
            return String(localized: "administrationType.liquid")
        case .device:
            return String(localized: "administrationType.device")
        case .foam:
            return String(localized: "administrationType.foam")
        case .gel:
            return String(localized: "administrationType.gel")
        case .inhaler:
            return String(localized: "administrationType.inhaler")
        case .injection:
            return String(localized: "administrationType.injection")
        case .lotion:
            return String(localized: "administrationType.lotion")
        case .ointment:
            return String(localized: "administrationType.ointment")
        case .powder:
            return String(localized: "administrationType.powder")
        case .spray:
            return String(localized: "administrationType.spray")
        case .other:
            return String(localized: "administrationType.other")
        }
    }
    
    var administrationTypeDescription: String {
        switch self {
        case .capsule:
            return String(localized: "administrationType.capsule")
        case .tablet:
            return String(localized: "administrationType.tablet")
        case .sachet:
            return String(localized: "administrationType.sachet")
        case .drop:
            return String(localized: "administrationType.drop")
        case .suppository:
            return String(localized: "administrationType.suppository")
        case .patch:
            return String(localized: "administrationType.patch")
        case .cream:
            return String(localized: "administrationType.genericDescription") + " " + String(localized: "administrationType.cream")
        case .liquid:
            return String(localized: "administrationType.genericDescription") + " " + String(localized: "administrationType.liquid")
        case .device:
            return String(localized: "administrationType.genericDescription") + " " + String(localized: "administrationType.device")
        case .foam:
            return String(localized: "administrationType.genericDescription") + " " + String(localized: "administrationType.foam")
        case .gel:
            return String(localized: "administrationType.genericDescription") + " " + String(localized: "administrationType.gel")
        case .inhaler:
            return String(localized: "administrationType.genericDescription") + " " + String(localized: "administrationType.inhaler")
        case .injection:
            return String(localized: "administrationType.genericDescription") + " " + String(localized: "administrationType.injection")
        case .lotion:
            return String(localized: "administrationType.genericDescription") + " " + String(localized: "administrationType.lotion")
        case .ointment:
            return String(localized: "administrationType.genericDescription") + " " + String(localized: "administrationType.ointment")
        case .powder:
            return String(localized: "administrationType.genericDescription") + " " + String(localized: "administrationType.powder")
        case .spray:
            return String(localized: "administrationType.genericDescription") + " " + String(localized: "administrationType.spray")
        case .other:
            return String(localized: "administrationType.genericDescription") + " " + String(localized: "administrationType.other")
        }
    }
    
    var administrationTypeDescriptionPlural: String {
        switch self {
        case .capsule:
            return String(localized: "administrationType.plural.capsule")
        case .tablet:
            return String(localized: "administrationType.plural.tablet")
        case .sachet:
            return String(localized: "administrationType.plural.sachet")
        case .drop:
            return String(localized: "administrationType.plural.drop")
        case .suppository:
            return String(localized: "administrationType.plural.suppository")
        case .patch:
            return String(localized: "administrationType.plural.patch")
        case .cream:
            return String(localized: "administrationType.plural.genericDescription") + " " + String(localized: "administrationType.cream")
        case .liquid:
            return String(localized: "administrationType.plural.genericDescription") + " " + String(localized: "administrationType.liquid")
        case .device:
            return String(localized: "administrationType.plural.genericDescription") + " " + String(localized: "administrationType.device")
        case .foam:
            return String(localized: "administrationType.plural.genericDescription") + " " + String(localized: "administrationType.foam")
        case .gel:
            return String(localized: "administrationType.plural.genericDescription") + " " + String(localized: "administrationType.gel")
        case .inhaler:
            return String(localized: "administrationType.plural.genericDescription") + " " + String(localized: "administrationType.inhaler")
        case .injection:
            return String(localized: "administrationType.plural.genericDescription") + " " + String(localized: "administrationType.injection")
        case .lotion:
            return String(localized: "administrationType.plural.genericDescription") + " " + String(localized: "administrationType.lotion")
        case .ointment:
            return String(localized: "administrationType.plural.genericDescription") + " " + String(localized: "administrationType.ointment")
        case .powder:
            return String(localized: "administrationType.plural.genericDescription") + " " + String(localized: "administrationType.powder")
        case .spray:
            return String(localized: "administrationType.plural.genericDescription") + " " + String(localized: "administrationType.spray")
        case .other:
            return String(localized: "administrationType.plural.genericDescription") + " " + String(localized: "administrationType.other")
        }
    }
}
