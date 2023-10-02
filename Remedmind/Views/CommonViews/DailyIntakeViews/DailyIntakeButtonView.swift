//
//  DailyIntakeButtonView.swift
//  Remedmind
//
//  Created by Davide Aliti on 01/03/23.
//

import SwiftUI

struct DailyIntakeButtonView: View {
    // MARK: - Properties
    var buttonHeight: CGFloat = 40
    
    var action: () -> Void
    var icon: String
    var font: Font = .body
    
    @EnvironmentObject var themeSettings: ThemeSettings
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(font)
                .frame(width: buttonHeight, height: buttonHeight)
                .foregroundColor(themeSettings.selectedThemeSecondaryColor)
                .overlay(Circle()
                    .stroke(themeSettings.selectedThemeSecondaryColor, style: StrokeStyle(lineWidth: 2)))
                
        }
    }
}

// MARK: - Preview
struct DailyIntakeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DailyIntakeButtonView(action: {print("Hi")}, icon: "plus")
            .environmentObject(ThemeSettings())
    }
}
