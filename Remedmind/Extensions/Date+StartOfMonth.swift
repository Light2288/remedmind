//
//  Date+StartOfMonth.swift
//  Remedmind
//
//  Created by Davide Aliti on 27/02/23.
//

import Foundation

extension Date {
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)
        ) ?? self
    }
}
