//
//  Reminder+Calendar.swift
//  Remedmind
//
//  Created by Davide Aliti on 26/04/23.
//

import Foundation

extension Reminder {
    
    var localizedLongAdministrationDays: [String] {
        let weekdays = Calendar.customLocalizedCalendar.weekdaySymbols
        let zippedWeekdaysAndAdministrationDays = Array(zip(weekdays, self.administrationDays))
        let localizedZipped = Array(zippedWeekdaysAndAdministrationDays[Calendar.customLocalizedCalendar.firstWeekday - 1 ..< Calendar.customLocalizedCalendar.veryShortWeekdaySymbols.count] + zippedWeekdaysAndAdministrationDays[0 ..< Calendar.customLocalizedCalendar.firstWeekday - 1])
        let localizedAdministrationDays = localizedZipped.filter { $0.1 }.map { $0.0 }
        return localizedAdministrationDays
    }
}
