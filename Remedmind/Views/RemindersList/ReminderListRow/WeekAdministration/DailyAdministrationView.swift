//
//  DailyAdministrationView.swift
//  Remedmind
//
//  Created by Davide Aliti on 09/02/23.
//

import SwiftUI

struct DailyAdministrationView: View {
    // MARK: - Properties
    var daySymbol: String
    var isCurrentDay: Bool
    @ObservedObject var reminder: Reminder
    var currentWeekday: Date
    var outerCircleDiameter: CGFloat = 35
    var innerCircleDiameter: CGFloat = 28
    
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var localizedCalendar : Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: Locale.preferredLanguages[0])
        return calendar
    }
    
    var takenIntakes: Int32? {
        return reminder.dailyIntakes?.filter({ dailyIntake in
            localizedCalendar.isDate(dailyIntake.date!, inSameDayAs: currentWeekday)
        }).first?.takenDailyIntakes
    }
    
    
    var dayTotalIntakes: Int32? {
        return reminder.dailyIntakes?.filter({ dailyIntake in
            localizedCalendar.isDate(dailyIntake.date!, inSameDayAs: currentWeekday)
        }).first?.todayTotalIntakes
    }
    
    var fraction: Double {
        guard let takenIntakes = takenIntakes, let dayTotalIntakes = dayTotalIntakes else { return 0 }
        return Double(takenIntakes)/Double(dayTotalIntakes)
    }
    
    var isIntakeDay: Bool {
        guard let dayTotalIntakes = dayTotalIntakes, dayTotalIntakes != 0 else { return false }
        return true
    }
    
    var textColor: Color {
        guard isIntakeDay else {
            return Color(.systemGray)
        }
        return isCurrentDay ? themeSettings.selectedThemeSecondaryColor : Color(.label)
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
    
    // MARK: - Body
    var body: some View {
        ZStack {
            OuterCircleEmpty(fillColor: outerCircleColor.opacity(0.25), strokeBorder: outerCircleStroke.strokeColor, strokeWidth: outerCircleStroke.strokeWidth)
                .frame(width: outerCircleDiameter, height: outerCircleDiameter, alignment: .center)
            
            if isIntakeDay {
                OuterCirclePieChart(fraction: fraction, fillColor: outerCircleColor, strokeBorder: outerCircleStroke.strokeColor, strokeWidth: outerCircleStroke.strokeWidth)
                    .frame(width: outerCircleDiameter, height: outerCircleDiameter, alignment: .center)
            }
            Circle()
                .fill(Color(.systemBackground))
                .frame(width: innerCircleDiameter, height: innerCircleDiameter, alignment: .center)
            Text(daySymbol)
                .foregroundColor(textColor)
                .font(.subheadline)
        }
    }
}

// MARK: - Preview
struct DailyAdministrationView_Previews: PreviewProvider {
    static var previews: some View {
        DailyAdministrationView(daySymbol: "L", isCurrentDay: true, reminder: Reminder(context: PersistenceController.preview.container.viewContext), currentWeekday: Date.now)
            .environmentObject(ThemeSettings())
            .previewLayout(.sizeThatFits)
    }
}
