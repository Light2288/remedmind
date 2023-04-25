//
//  WeekAdministrationView.swift
//  Remedmind
//
//  Created by Davide Aliti on 09/02/23.
//

import SwiftUI

struct WeekAdministrationView: View {
    // MARK: - Properties
    @EnvironmentObject var themeSettings: ThemeSettings
    @State var reminder: Reminder
    
    var localizedCalendar : Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: Locale.preferredLanguages[0])
        return calendar
    }
    
    var localizedVeryShortWeekdaysSymbols: [String] {
        Array(localizedCalendar.veryShortWeekdaySymbols[localizedCalendar.firstWeekday - 1 ..< localizedCalendar.veryShortWeekdaySymbols.count] + localizedCalendar.veryShortWeekdaySymbols[0 ..< localizedCalendar.firstWeekday - 1])
    }
    
    var isCurrentDay: [Bool] {
        localizedCalendar.weekdaySymbols.enumerated().map { $0.0 == localizedCalendar.component(.weekday, from: Date()) - 1}
    }
    
    var localizedIsCurrentDay: [Bool] {
        Array(isCurrentDay[localizedCalendar.firstWeekday - 1 ..< localizedCalendar.veryShortWeekdaySymbols.count] + isCurrentDay[0 ..< localizedCalendar.firstWeekday - 1])
    }
    
    var currentWeekDays: [Date] {
        let startOfCurrentWeek = localizedCalendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date.now).date!
        let endOfWeekOffset = localizedCalendar.weekdaySymbols.count - 1
        let endOfWeekComponents = DateComponents(day: endOfWeekOffset, hour: 23, minute: 59, second: 59)
        let endOfCurrentWeek = localizedCalendar.date(byAdding: endOfWeekComponents, to: startOfCurrentWeek)!
        
        var tempDate = startOfCurrentWeek
        var array = [tempDate]
        
        while tempDate < endOfCurrentWeek {
            tempDate = localizedCalendar.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        
        return array
    }
    
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(0..<7, id: \.self) { index in
                DailyAdministrationView(daySymbol: localizedVeryShortWeekdaysSymbols[index], isCurrentDay: localizedIsCurrentDay[index], reminder: reminder, currentWeekday: currentWeekDays[index])
                    .environmentObject(self.themeSettings)
            }
        }
    }
}

// MARK: - Preview
struct WeekAdministrationView_Previews: PreviewProvider {
    static var previews: some View {
        WeekAdministrationView(reminder: Reminder(context: PersistenceController.preview.container.viewContext))
            .environmentObject(ThemeSettings())
            .previewLayout(.sizeThatFits)
    }
}
