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
    @State var selectedDay: Date = Date.now
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(Calendar.customLocalizedCalendar.currentWeekDays, id: \.self) { day in
                if reminder.isIntakeDay(for: day) {
                    if(Calendar.customLocalizedCalendar.isDate(selectedDay, inSameDayAs: day)) {
                        WeekAdministrationAddIntakeView(reminder: reminder, selectedDay: $selectedDay)
                            .onTapGesture {
                                // empty onTapGesture to prevent navigation when tapping
                            }
                    } else {
                        IntakeDayView(text: DateFormatter.weekDayFormatter.string(from: day), outerCircleDiameter: 25, innerCircleDiameter: 20, day: day, onButtonTap: {}, selectedDayTextColor: Color(.label), font: .footnote, displayCurrentDayIndicator: false, selectedDay: $selectedDay, reminder: reminder)
                            .onTapGesture {
                                selectedDay = day
                            }
                    }
                } else {
                    NoIntakeDayView(text: DateFormatter.weekDayFormatter.string(from: day), frameSize: 25, day: day, font: .footnote)
                }
            }
        }
    }
}

// MARK: - Preview
struct WeekAdministrationView_Previews: PreviewProvider {
    static var previews: some View {
        WeekAdministrationView(reminder: Reminder(context: PersistenceController.preview.container.viewContext), selectedDay: Date.now)
            .environmentObject(ThemeSettings())
            .previewLayout(.sizeThatFits)
    }
}
