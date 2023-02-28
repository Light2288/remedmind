//
//  DateFormatter+Init.swift
//  Remedmind
//
//  Created by Davide Aliti on 27/02/23.
//

import Foundation

extension DateFormatter {
    convenience init(dateFormat: String, calendar: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
    }
}
