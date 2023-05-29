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
    @ObservedObject var reminder: Reminder
    @Binding var selectedDay: Date
    @Binding var selectedReminder: Reminder?
    @Binding var showAddIntakeOverlayView: Bool
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(Calendar.customLocalizedCalendar.currentWeekDays, id: \.self) { day in
                if reminder.isIntakeDay(for: day) {
                    IntakeDayView(text: DateFormatter.weekDayFormatter.string(from: day), outerCircleDiameter: 35, innerCircleDiameter: 28, day: day, onButtonTap: {}, selectedDayTextColor: Color(.label), selectedDay: $selectedDay, reminder: reminder)
                        .onLongPressGesture {
                            selectedDay = day
                            selectedReminder = reminder
                            showAddIntakeOverlayView.toggle()
                        }
                } else {
                    NoIntakeDayView(text: DateFormatter.weekDayFormatter.string(from: day), frameSize: 35, day: day)
                }
            }
//            ForEach(0..<7, id: \.self) { index in
//                DailyAdministrationView(daySymbol: Calendar.localizedVeryShortWeekdaysSymbols[index], isCurrentDay: Calendar.customLocalizedCalendar.localizedIsCurrentDayArray[index], reminder: reminder, currentWeekday: Calendar.customLocalizedCalendar.currentWeekDays[index])
//                    .environmentObject(self.themeSettings)
//            }
        }
    }
}

// MARK: - Preview
struct WeekAdministrationView_Previews: PreviewProvider {
    static var previews: some View {
        WeekAdministrationView(reminder: Reminder(context: PersistenceController.preview.container.viewContext), selectedDay: .constant(Date.now), selectedReminder: .constant(Reminder(context: PersistenceController.preview.container.viewContext)), showAddIntakeOverlayView: .constant(false))
            .environmentObject(ThemeSettings())
            .previewLayout(.sizeThatFits)
    }
}
