//
//  Reminder+Enums.swift
//  Remedmind
//
//  Created by Davide Aliti on 25/04/23.
//

import Foundation

extension Reminder {
    var administrationFrequencyEnumValue: AdministrationFrequency? {
        return AdministrationFrequency(rawValue: self.administrationFrequency ?? "")
    }
    
    var administrationTypeEnumValue: AdministrationType? {
        return AdministrationType(rawValue: self.administrationType ?? "")
    }
}
