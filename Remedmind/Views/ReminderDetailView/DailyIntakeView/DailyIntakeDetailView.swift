//
//  DailyIntakeDetailView.swift
//  Remedmind
//
//  Created by Davide Aliti on 02/03/23.
//

import SwiftUI

struct DailyIntakeDetailView: View {
    // MARK: - Properties
    let height: CGFloat
    let numberOfAdministrations: Int
    
    @ObservedObject var reminder: Reminder
    @Binding var selectedDay: Date
    
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }
    
    var localizedCalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: Locale.preferredLanguages[0])
        return calendar
    }
    
    var takenDailyIntake: Int32 {
        return reminder.dailyIntakes?.filter({ dailyIntake in
            localizedCalendar.isDate(dailyIntake.date!, inSameDayAs: selectedDay)
        }).first?.takenDailyIntakes ?? 0
    }
    
    var dayTotalIntakes: Int32 {
        return reminder.dailyIntakes?.filter({ dailyIntake in
            localizedCalendar.isDate(dailyIntake.date!, inSameDayAs: selectedDay)
        }).first?.todayTotalIntakes ?? 0
    }
    
    var fraction: Double {
        guard dayTotalIntakes != 0 else { return 0 }
        return Double(takenDailyIntake)/Double(dayTotalIntakes)
    }
    
    var isIntakeDay: Bool {
        guard dayTotalIntakes != 0 else { return false }
        return true
    }
    
    var outerCircleColor: Color {
        guard dayTotalIntakes != 0 else {
            return Color(.clear)
        }
        return themeSettings.selectedThemePrimaryColor
    }
    
    var outerCircleStroke: (strokeColor: Color, strokeWidth: Double) {
        guard dayTotalIntakes != 0 else {
            return (strokeColor: Color(.systemGray), strokeWidth: 1)
        }
        return (strokeColor: Color(.clear), strokeWidth: 0)
    }

    
    // MARK: - Body
    var body: some View {
        ZStack {
            OuterCircleEmpty(fillColor: outerCircleColor.opacity(0.25), strokeBorder: outerCircleStroke.strokeColor, strokeWidth: outerCircleStroke.strokeWidth)
                .frame(width: height, height: height, alignment: .center)
                .zIndex(0)
            
            if isIntakeDay {
                OuterCirclePieChart(fraction: fraction, fillColor: outerCircleColor, strokeBorder: outerCircleStroke.strokeColor, strokeWidth: outerCircleStroke.strokeWidth)
                    .frame(width: height, height: height, alignment: .center)
                    .zIndex(1)
            }
            Circle()
                .fill(Color(.systemBackground))
                .frame(width: height-20, height: height-20, alignment: .center)
                .zIndex(2)
            VStack {
                Text("\(takenDailyIntake.description)/\(dayTotalIntakes.description)")
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 3, trailing: 0))
                    .font(.title)
                Text(dateFormatter.string(from: selectedDay))
                    .font(.footnote)
                Spacer()
            }
            .zIndex(3)
        }
        .frame(width: height, height: height)
    }
}

// MARK: - Preview
struct DailyIntakeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DailyIntakeDetailView(height: 120, numberOfAdministrations: 5, reminder: Reminder(context: PersistenceController.preview.container.viewContext), selectedDay: .constant(Date.now))
            .environmentObject(ThemeSettings())
    }
}
