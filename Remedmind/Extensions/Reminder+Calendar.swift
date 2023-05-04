//
//  Reminder+Calendar.swift
//  Remedmind
//
//  Created by Davide Aliti on 26/04/23.
//

import Foundation

extension Reminder {
    var unlocalizedAdministrationDays: [Bool] { Array(self.administrationDays[Calendar.customLocalizedCalendar.veryShortWeekdaySymbols.count - Calendar.customLocalizedCalendar.firstWeekday + 1 ..< Calendar.customLocalizedCalendar.veryShortWeekdaySymbols.count] + self.administrationDays[0 ..< Calendar.customLocalizedCalendar.veryShortWeekdaySymbols.count - Calendar.customLocalizedCalendar.firstWeekday + 1])
    }
}
