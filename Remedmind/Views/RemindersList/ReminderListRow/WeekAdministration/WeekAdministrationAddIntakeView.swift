//
//  WeekAdministrationAddIntakeView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/09/23.
//

import SwiftUI

struct WeekAdministrationAddIntakeView: View {
    // MARK: - Properties
    let height: CGFloat = 110
    let hapticFeedback = UINotificationFeedbackGenerator()
    @ObservedObject var reminder: Reminder
    @Binding var selectedDay: Date
    
    @EnvironmentObject var themeSettings: ThemeSettings
    @Environment(\.managedObjectContext) private var viewContext
    
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
            
            OuterCirclePieChart(fraction: reminder.getFractionOfTakenIntakes(for: selectedDay), fillColor: outerCircleColor, strokeBorder: outerCircleStroke.strokeColor, strokeWidth: outerCircleStroke.strokeWidth)
                .frame(width: height, height: height, alignment: .center)
                .zIndex(1)

            Circle()
                .fill(Color(.systemBackground))
                .frame(width: height-10, height: height-10, alignment: .center)
                .zIndex(2)
            HStack {
                DailyIntakeButtonView(buttonHeight: 20, action: {
                }, icon: "minus", font: .footnote)
                .onTapGesture {
                    guard let takenIntakes = reminder.getTakenIntakes(for: selectedDay) else { return }
                    if takenIntakes > 0 {
                        reminder.updateTakenDailyIntakes(for: selectedDay, intakesToAdd: -1, context: viewContext)
                        reminder.updateCurrentPackageQuantity(by: -reminder.administrationQuantity, context: viewContext)
                        hapticFeedback.notificationOccurred(.success)
                        playSound(soundName: "add-remove-success", type: "mp3")
                    } else {
                        hapticFeedback.notificationOccurred(.error)
                        playSound(soundName: "add-remove-error", type: "wav")
                    }
                    return
                }
                VStack {
                    Text("\(reminder.getTakenIntakes(for: selectedDay)?.description ?? "0")/\(reminder.getTotalIntakes(for: selectedDay)?.description ?? "0")")
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
                        .font(.body)
                    Spacer()
                    Text(DateFormatter.longWeekDayFormatter.string(from: selectedDay).capitalizedFirstLetter)
                        .font(.body)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                    
                }
                DailyIntakeButtonView(buttonHeight: 20, action: {
                }, icon: "plus", font: .footnote)
                .onTapGesture {
                    reminder.updateTakenDailyIntakes(for: selectedDay, intakesToAdd: +1, context: viewContext)
                    reminder.updateCurrentPackageQuantity(by: reminder.administrationQuantity, context: viewContext)
                    hapticFeedback.notificationOccurred(.success)
                    playSound(soundName: "add-remove-success", type: "mp3")
                    return
                }
            }
            .zIndex(3)
        }
        .frame(width: height, height: height)
    }
}

// MARK: - Preview
struct WeekAdministrationAddIntakeView_Previews: PreviewProvider {
    static var previews: some View {
        WeekAdministrationAddIntakeView(reminder: Reminder(context: PersistenceController.preview.container.viewContext), selectedDay: .constant(Date.now))
    }
}
