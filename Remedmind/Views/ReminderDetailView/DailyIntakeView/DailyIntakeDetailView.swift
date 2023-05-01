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
    
    @ObservedObject var reminder: Reminder
    @Binding var selectedDay: Date
    
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var outerCircleColor: Color {
        guard reminder.getTotalIntakes(for: selectedDay) != 0 else {
            return Color(.clear)
        }
        return themeSettings.selectedThemePrimaryColor
    }
    
    var outerCircleStroke: (strokeColor: Color, strokeWidth: Double) {
        guard reminder.getTotalIntakes(for: selectedDay) != 0 else {
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
            
            if reminder.isIntakeDay(for: selectedDay) {
                OuterCirclePieChart(fraction: reminder.getFractionOfTakenIntakes(for: selectedDay), fillColor: outerCircleColor, strokeBorder: outerCircleStroke.strokeColor, strokeWidth: outerCircleStroke.strokeWidth)
                    .frame(width: height, height: height, alignment: .center)
                    .zIndex(1)
            }
            Circle()
                .fill(Color(.systemBackground))
                .frame(width: height-20, height: height-20, alignment: .center)
                .zIndex(2)
            VStack {
                Text("\(reminder.getTakenIntakes(for: selectedDay)?.description ?? "0")/\(reminder.getTotalIntakes(for: selectedDay)?.description ?? "0")")
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 3, trailing: 0))
                    .font(.title)
                Text(DateFormatter.dayMonthYearFormatter.string(from: selectedDay))
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
        DailyIntakeDetailView(height: 120, reminder: Reminder(context: PersistenceController.preview.container.viewContext), selectedDay: .constant(Date.now))
            .environmentObject(ThemeSettings())
    }
}
