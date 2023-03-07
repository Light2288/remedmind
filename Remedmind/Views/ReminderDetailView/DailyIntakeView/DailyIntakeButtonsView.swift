//
//  DailyIntakeButtonsView.swift
//  Remedmind
//
//  Created by Davide Aliti on 02/03/23.
//

import SwiftUI

struct DailyIntakeButtonsView: View {
    // MARK: - Properties
    @Binding var dailyIntake: Int
    
    // MARK: - Body
    var body: some View {
        HStack {
            DailyIntakeButtonView(action: {dailyIntake -= 1}, icon: "minus")
            Spacer()
            DailyIntakeButtonView(action: {dailyIntake += 1}, icon: "plus")
        }
        .padding()
    }
}

// MARK: - Preview
struct DailyIntakeButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyIntakeButtonsView(dailyIntake: .constant(0))
            .environmentObject(ThemeSettings())
    }
}
