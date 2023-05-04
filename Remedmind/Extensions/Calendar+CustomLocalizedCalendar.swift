//
//  Calendar+CustomLocalizedCalendar.swift
//  Remedmind
//
//  Created by Davide Aliti on 25/04/23.
//

import Foundation

extension Calendar {
    static var customLocalizedCalendar: Calendar {
        var localizedCalendar : Calendar = Calendar(identifier: .gregorian)
        localizedCalendar.locale = Locale(identifier: Locale.preferredLanguages[0])
        return localizedCalendar
    }
    
    static var localizedVeryShortWeekdaysSymbols: [String] {
        return Array(self.customLocalizedCalendar.veryShortWeekdaySymbols[self.customLocalizedCalendar.firstWeekday - 1 ..< self.customLocalizedCalendar.veryShortWeekdaySymbols.count] + self.customLocalizedCalendar.veryShortWeekdaySymbols[0 ..< self.customLocalizedCalendar.firstWeekday - 1])
    }
    
    var isCurrentDayArray: [Bool] {
        self.weekdaySymbols.enumerated().map { $0.0 == self.component(.weekday, from: Date.now) - 1}
    }
    
    var localizedIsCurrentDayArray: [Bool] {
        Array(isCurrentDayArray[self.firstWeekday - 1 ..< self.veryShortWeekdaySymbols.count] + isCurrentDayArray[0 ..< self.firstWeekday - 1])
    }
    
    var currentWeekDays: [Date] {
        let startOfCurrentWeek = self.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date.now).date!
        let endOfWeekOffset = self.weekdaySymbols.count - 1
        let endOfWeekComponents = DateComponents(day: endOfWeekOffset, hour: 23, minute: 59, second: 59)
        let endOfCurrentWeek = self.date(byAdding: endOfWeekComponents, to: startOfCurrentWeek)!
        
        var tempDate = startOfCurrentWeek
        var array: [Date] = []
        
        while tempDate < endOfCurrentWeek {
            array.append(tempDate)
            tempDate = self.date(byAdding: .day, value: 1, to: tempDate)!
        }
        
        return array
    }
    
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day ?? 0
    }
}
