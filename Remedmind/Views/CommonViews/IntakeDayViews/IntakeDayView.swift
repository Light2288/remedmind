//
//  IntakeDayView.swift
//  Remedmind
//
//  Created by Davide Aliti on 02/05/23.
//

import SwiftUI

struct IntakeDayView: View {
    // MARK: - Properties
    let text: String
    let outerCircleDiameter: CGFloat
    let innerCircleDiameter: CGFloat
    var day: Date
    var onButtonTap: () -> Void
    var selectedDayTextColor: Color
    
    @Binding var selectedDay: Date
    @ObservedObject var reminder: Reminder
    @EnvironmentObject var themeSettings: ThemeSettings
    
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
    
    // MARK: - Body
    var body: some View {
        Button {
            onButtonTap()
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
                Text(text)
                    .foregroundColor(
                        Calendar.customLocalizedCalendar.isDate(day, inSameDayAs: selectedDay) ? selectedDayTextColor
                        : Color(.label)
                    )
                if Calendar.customLocalizedCalendar.isDateInToday(day) {
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
struct IntakeDayView_Previews: PreviewProvider {
    static var previews: some View {
        IntakeDayView(text: DateFormatter.dayFormatter.string(from: Date.now), outerCircleDiameter: 35, innerCircleDiameter: 28, day: Date.now, onButtonTap: {print("Tapped")}, selectedDayTextColor: ThemeSettings().selectedThemeSecondaryColor, selectedDay: .constant(Date.now), reminder: Reminder(context: PersistenceController.preview.container.viewContext))
    }
}
