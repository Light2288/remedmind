//
//  Administration.swift
//  Remedmind
//
//  Created by Davide Aliti on 05/12/22.
//

import Foundation

enum AdministrationFrequency: String, CaseIterable {
    case daily
    case everyOtherDay
    case weekly
}

enum AdministrationType: String, CaseIterable {
    case capsule
    case tablet
    case sachet
    case drop
    case suppository
    case patch
    case cream
    case liquid
    case device    
    case foam
    case gel
    case inhaler
    case injection
    case lotion
    case ointment
    case powder
    case spray
    case other
}
