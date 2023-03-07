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
    @State var dailyIntake: Int = 0
    @State var offset: CGSize = .zero
    @State var dailyIntakeCapsuleViewSize: CGSize = .zero
    
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
                        dailyIntake -= 1
                    } else if drag.translation.width > maxLateralTranslation {
                        dailyIntake += 1
                    }
                }
                withAnimation(.spring()) {
                    offset = .zero
                }
            }
        
        return ZStack {
            DailyIntakeCapsuleView(height: height)
                .saveSize(in: $dailyIntakeCapsuleViewSize)
            DailyIntakeButtonsView(dailyIntake: $dailyIntake)
            DailyIntakeDetailView(height: height, numberOfAdministrations: numberOfAdministrations, dailyIntake: $dailyIntake, selectedDay: $selectedDay)
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
        DailyIntakeView(numberOfAdministrations: 5, selectedDay: .constant(Date.now))
            .environmentObject(ThemeSettings())
    }
}
