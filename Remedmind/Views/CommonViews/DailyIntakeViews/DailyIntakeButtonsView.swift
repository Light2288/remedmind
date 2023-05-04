//
//  DailyIntakeButtonsView.swift
//  Remedmind
//
//  Created by Davide Aliti on 02/03/23.
//

import SwiftUI

struct DailyIntakeButtonsView: View {
    // MARK: - Properties
    var minusButtonAction: () -> Void
    var plusButtonAction: () -> Void
    
    // MARK: - Body
    var body: some View {
        HStack {
            DailyIntakeButtonView(action: minusButtonAction, icon: "minus")
            Spacer()
            DailyIntakeButtonView(action: plusButtonAction, icon: "plus")
        }
        .padding()
    }
}

// MARK: - Preview
struct DailyIntakeButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyIntakeButtonsView(minusButtonAction: { return }, plusButtonAction: { return })
            .environmentObject(ThemeSettings())
    }
}
