//
//  Administration.swift
//  Remedmind
//
//  Created by Davide Aliti on 05/12/22.
//

import Foundation

enum AdministrationFrequency: String, CaseIterable {
    case daily
    case weekly
}

enum AdministrationType: String, CaseIterable {
    case pill
    case sachet
    case drop
    case other
}
