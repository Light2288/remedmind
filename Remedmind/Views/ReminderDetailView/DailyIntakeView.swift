//
//  DailyIntakeView.swift
//  Remedmind
//
//  Created by Davide Aliti on 17/02/23.
//

import SwiftUI

struct DailyIntakeView: View {
    // MARK: - Properties
    let height: CGFloat = 120
    let maxWidth: CGFloat = 450
    let numberOfAdministrations: Int
    
    @Binding var selectedDay: Date
    @Binding var reminder: Reminder
    @State var offset: CGSize = .zero
    @State var dailyIntakeCapsuleViewSize: CGSize = .zero
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var localizedCalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: Locale.preferredLanguages[0])
        return calendar
    }
    
    func saveToTakenDailyIntakes(reminder: Reminder, intakesToAdd: Int32) {
        let dailyIntake = reminder.dailyIntakes?.filter({ dailyIntake in
            localizedCalendar.isDate(dailyIntake.date!, inSameDayAs: selectedDay)
        }).first
        guard let takenDailyIntake = dailyIntake else { return }
        takenDailyIntake.takenDailyIntakes += intakesToAdd
        reminder.addToDailyIntakes(takenDailyIntake)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        print(reminder.id)
        print(reminder.dailyIntakes?.filter({ dailyIntake in
            localizedCalendar.isDate(dailyIntake.date!, inSameDayAs: selectedDay)
        }).count)
        print(reminder.dailyIntakes?.filter({ dailyIntake in
            localizedCalendar.isDate(dailyIntake.date!, inSameDayAs: selectedDay)
        }).first?.todayTotalIntakes)
        print(reminder.dailyIntakes?.filter({ dailyIntake in
            localizedCalendar.isDate(dailyIntake.date!, inSameDayAs: selectedDay)
        }).first?.takenDailyIntakes)
    }
    
    // MARK: - Body
    var body: some View {
        let drag = DragGesture()
            .onChanged {
                let maxRightTranslation = min($0.translation.width, dailyIntakeCapsuleViewSize.width/2 - height/2)
                let maxTranslation = max(maxRightTranslation, -dailyIntakeCapsuleViewSize.width/2 + height/2)
                offset = CGSize(width: maxTranslation, height: 0)
            }
            .onEnded { drag in
                let maxLateralTranslation = dailyIntakeCapsuleViewSize.width/2 - height/2 - 15
                defer {
                    if drag.translation.width < -maxLateralTranslation {
                        saveToTakenDailyIntakes(reminder: reminder, intakesToAdd: -1)
                    } else if drag.translation.width > maxLateralTranslation {
                        saveToTakenDailyIntakes(reminder: reminder, intakesToAdd: 1)
                    }
                }
                withAnimation(.spring()) {
                    offset = .zero
                }
            }
        
        return ZStack {
            DailyIntakeCapsuleView(height: height)
                .saveSize(in: $dailyIntakeCapsuleViewSize)
            DailyIntakeButtonsView(minusButtonAction: { return saveToTakenDailyIntakes(reminder: reminder, intakesToAdd: -1)}, plusButtonAction: { return saveToTakenDailyIntakes(reminder: reminder, intakesToAdd: +1) })
            DailyIntakeDetailView(height: height, numberOfAdministrations: numberOfAdministrations, reminder: reminder, selectedDay: $selectedDay)
                .offset(offset)
                .gesture(drag)
        }
        .padding([.top, .leading, .trailing])
        .frame(maxWidth: maxWidth)
    }
}

// MARK: - Preview
struct DailyIntakeView_Previews: PreviewProvider {
    static var previews: some View {
        DailyIntakeView(numberOfAdministrations: 5, selectedDay: .constant(Date.now), reminder: .constant(Reminder(context: PersistenceController.preview.container.viewContext)))
            .environmentObject(ThemeSettings())
    }
}
