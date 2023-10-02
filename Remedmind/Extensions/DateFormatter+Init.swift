//
//  DateFormatter+Init.swift
//  Remedmind
//
//  Created by Davide Aliti on 27/02/23.
//

import Foundation

extension DateFormatter {
    convenience init(dateFormat: String, calendar: Calendar = Calendar.customLocalizedCalendar, locale: Locale = Locale(identifier: Locale.preferredLanguages[0])) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
        self.locale = locale
    }
    
    static var dayMonthYearFormatter: DateFormatter {
        DateFormatter(dateFormat: "dd MMM yyyy")
    }
    
    static var monthYearFormatter: DateFormatter {
        DateFormatter(dateFormat: "MMMM yyyy")
    }
    
    static var dayFormatter: DateFormatter {
        DateFormatter(dateFormat: "d")
    }
    
    static var weekDayFormatter: DateFormatter {
        DateFormatter(dateFormat: "EEEEE")
    }
    
    static var longWeekDayFormatter: DateFormatter {
        DateFormatter(dateFormat: "EEE")
    }
    
    static var hourMinuteFormatter: DateFormatter {
        DateFormatter(dateFormat: "HH:mm")
    }
}
