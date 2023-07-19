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
    
    @Binding var selectedDay: Date
    @Binding var reminder: Reminder
    @State var offset: CGSize = .zero
    @State var dailyIntakeCapsuleViewSize: CGSize = .zero
    
    @Environment(\.managedObjectContext) private var viewContext
    
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
                        reminder.updateTakenDailyIntakes(for: selectedDay, intakesToAdd: -1, context: viewContext)
                        reminder.updateCurrentPackageQuantity(by: -reminder.administrationQuantity, context: viewContext)
                    } else if drag.translation.width > maxLateralTranslation {
                        reminder.updateTakenDailyIntakes(for: selectedDay, intakesToAdd: +1, context: viewContext)
                        reminder.updateCurrentPackageQuantity(by: reminder.administrationQuantity, context: viewContext)
                    }
                }
                withAnimation(.spring()) {
                    offset = .zero
                }
            }
        
        return ZStack {
            DailyIntakeCapsuleView(height: height)
                .saveSize(in: $dailyIntakeCapsuleViewSize)
            DailyIntakeButtonsView(
                minusButtonAction: {
                    reminder.updateTakenDailyIntakes(for: selectedDay, intakesToAdd: -1, context: viewContext)
                    reminder.updateCurrentPackageQuantity(by: -reminder.administrationQuantity, context: viewContext)
                    return
                },
                plusButtonAction: {
                    reminder.updateTakenDailyIntakes(for: selectedDay, intakesToAdd: +1, context: viewContext)
                    reminder.updateCurrentPackageQuantity(by: reminder.administrationQuantity, context: viewContext)
                    return
                    
                }
            )
            DailyIntakeDetailView(height: height, reminder: reminder, selectedDay: $selectedDay)
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
        DailyIntakeView(selectedDay: .constant(Date.now), reminder: .constant(Reminder(context: PersistenceController.preview.container.viewContext)))
            .environmentObject(ThemeSettings())
    }
}
