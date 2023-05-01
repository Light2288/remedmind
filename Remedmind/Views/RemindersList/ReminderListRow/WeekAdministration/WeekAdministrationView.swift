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
    
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(0..<7, id: \.self) { index in
                DailyAdministrationView(daySymbol: Calendar.localizedVeryShortWeekdaysSymbols[index], isCurrentDay: Calendar.customLocalizedCalendar.localizedIsCurrentDayArray[index], reminder: reminder, currentWeekday: Calendar.customLocalizedCalendar.currentWeekDays[index])
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
