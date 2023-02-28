//
//  CalendarIntakeDayView.swift
//  Remedmind
//
//  Created by Davide Aliti on 27/02/23.
//

import SwiftUI

struct CalendarIntakeDayView: View {
    // MARK: - Properties
    let outerCircleDiameter: CGFloat = 35
    let innerCircleDiameter: CGFloat = 28
    
    var calendar: Calendar
    var day: Date
    @Binding var selectedDay: Date
    
    private var dayFormatter: DateFormatter {
        DateFormatter(dateFormat: "d", calendar: calendar)
    }
    
    @EnvironmentObject var themeSettings: ThemeSettings
    
    // MARK: - Body
    var body: some View {
        Button {
            selectedDay = day
        } label: {
            ZStack {
                Group {
                    Circle()
                        .fill(themeSettings.selectedThemePrimaryColor)
                        .frame(width: outerCircleDiameter, height: outerCircleDiameter, alignment: .center)
                    Circle()
                        .fill(Color(.systemBackground))
                        .frame(width: innerCircleDiameter, height: innerCircleDiameter, alignment: .center)
                }
                Text(dayFormatter.string(from: day))
                    .foregroundColor(
                        calendar.isDateInToday(day) ? themeSettings.selectedThemeSecondaryColor
                        : Color(.label)
                    )
            }
        }
    }
}

// MARK: - Preview
struct CalendarIntakeDayView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarIntakeDayView(calendar: Calendar(identifier: .gregorian), day: Date.now, selectedDay: .constant(Date.now))
            .environmentObject(ThemeSettings())
    }
}
