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
    
    @ObservedObject var reminder: Reminder
    
    var outerCircleColor: Color {
        guard let totalIntakes = reminder.getTotalIntakes(for: day), totalIntakes != 0 else {
            return Color(.clear)
        }
        return themeSettings.selectedThemePrimaryColor
    }
    
    var outerCircleStroke: (strokeColor: Color, strokeWidth: Double) {
        guard let totalIntakes = reminder.getTotalIntakes(for: day), totalIntakes != 0 else {
            return (strokeColor: Color(.systemGray), strokeWidth: 1)
        }
        return (strokeColor: Color(.clear), strokeWidth: 0)
    }
    
    @EnvironmentObject var themeSettings: ThemeSettings
    
    // MARK: - Body
    var body: some View {
        Button {
            selectedDay = day
        } label: {
            ZStack {
                Group {
                    OuterCircleEmpty(fillColor: outerCircleColor.opacity(0.25), strokeBorder: outerCircleStroke.strokeColor, strokeWidth: outerCircleStroke.strokeWidth)
                        .frame(width: outerCircleDiameter, height: outerCircleDiameter, alignment: .center)
                    OuterCirclePieChart(fraction: reminder.getFractionOfTakenIntakes(for: day), fillColor: outerCircleColor, strokeBorder: outerCircleStroke.strokeColor, strokeWidth: outerCircleStroke.strokeWidth)
                            .frame(width: outerCircleDiameter, height: outerCircleDiameter, alignment: .center)
                    Circle()
                        .fill(Color(.systemBackground))
                        .frame(width: innerCircleDiameter, height: innerCircleDiameter, alignment: .center)
                }
                Text(DateFormatter.dayFormatter.string(from: day))
                    .foregroundColor(
                        calendar.isDate(day, inSameDayAs: selectedDay) ? themeSettings.selectedThemeSecondaryColor
                        : Color(.label)
                    )
                if calendar.isDateInToday(day) {
                    Circle()
                        .foregroundColor(themeSettings.selectedThemePrimaryColor)
                        .frame(width: 4, height: 4)
                        .offset(x: 0, y: 10)
                }
            }
        }
    }
}

// MARK: - Preview
struct CalendarIntakeDayView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarIntakeDayView(calendar: Calendar(identifier: .gregorian), day: Date.now, selectedDay: .constant(Date.now), reminder: Reminder(context: PersistenceController.preview.container.viewContext))
            .environmentObject(ThemeSettings())
    }
}
