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
    let hapticFeedback = UINotificationFeedbackGenerator()
    
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
                guard let takenIntakes = reminder.getTakenIntakes(for: selectedDay) else { return }
                let maxRightLateralTranslation = dailyIntakeCapsuleViewSize.width/2 - height/2 - 15
                let maxLeftLateralTranslation = -maxRightLateralTranslation
                defer {
                    if drag.translation.width < maxLeftLateralTranslation {
                        if takenIntakes > 0 {
                            reminder.updateTakenDailyIntakes(for: selectedDay, intakesToAdd: -1, context: viewContext)
                            reminder.updateCurrentPackageQuantity(by: -reminder.administrationQuantity, context: viewContext)
                            hapticFeedback.notificationOccurred(.success)
                        }
                        else {
                            hapticFeedback.notificationOccurred(.error)
                        }
                    } else if drag.translation.width > maxRightLateralTranslation {
                        reminder.updateTakenDailyIntakes(for: selectedDay, intakesToAdd: +1, context: viewContext)
                        reminder.updateCurrentPackageQuantity(by: reminder.administrationQuantity, context: viewContext)
                        hapticFeedback.notificationOccurred(.success)
                    }
                }
                withAnimation(.interpolatingSpring(stiffness: 170, damping: 13)) {
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
                    hapticFeedback.notificationOccurred(.success)
                    return
                },
                plusButtonAction: {
                    reminder.updateTakenDailyIntakes(for: selectedDay, intakesToAdd: +1, context: viewContext)
                    reminder.updateCurrentPackageQuantity(by: reminder.administrationQuantity, context: viewContext)
                    hapticFeedback.notificationOccurred(.success)
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
