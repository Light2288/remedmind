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
    
    private var dayFormatter: DateFormatter {
        DateFormatter(dateFormat: "d", calendar: calendar)
    }
    
    var outerCircleColor: Color {
        guard let dayTotalIntakes = dayTotalIntakes, dayTotalIntakes != 0 else {
            return Color(.clear)
        }
        return themeSettings.selectedThemePrimaryColor
    }
    
    var outerCircleStroke: (strokeColor: Color, strokeWidth: Double) {
        guard let dayTotalIntakes = dayTotalIntakes, dayTotalIntakes != 0 else {
            return (strokeColor: Color(.systemGray), strokeWidth: 1)
        }
        return (strokeColor: Color(.clear), strokeWidth: 0)
    }
    
    var takenIntakes: Int32? {
        return reminder.dailyIntakes?.filter({ dailyIntake in
            calendar.isDate(dailyIntake.date!, inSameDayAs: day)
        }).first?.takenDailyIntakes
    }
    
    
    var dayTotalIntakes: Int32? {
        return reminder.dailyIntakes?.filter({ dailyIntake in
            calendar.isDate(dailyIntake.date!, inSameDayAs: day)
        }).first?.todayTotalIntakes
    }
    
    var fraction: Double {
        guard let takenIntakes = takenIntakes, let dayTotalIntakes = dayTotalIntakes else { return 0 }
        return Double(takenIntakes)/Double(dayTotalIntakes)
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
                    OuterCirclePieChart(fraction: fraction, fillColor: outerCircleColor, strokeBorder: outerCircleStroke.strokeColor, strokeWidth: outerCircleStroke.strokeWidth)
                            .frame(width: outerCircleDiameter, height: outerCircleDiameter, alignment: .center)
                    Circle()
                        .fill(Color(.systemBackground))
                        .frame(width: innerCircleDiameter, height: innerCircleDiameter, alignment: .center)
                }
                Text(dayFormatter.string(from: day))
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
