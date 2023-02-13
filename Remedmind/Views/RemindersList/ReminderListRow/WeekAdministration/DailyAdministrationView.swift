//
//  DailyAdministrationView.swift
//  Remedmind
//
//  Created by Davide Aliti on 09/02/23.
//

import SwiftUI

struct DailyAdministrationView: View {
    // MARK: - Properties
    var daySymbol: String
    var isCurrentDay: Bool
    var outerCircleDiameter: CGFloat = 35
    var innerCircleDiameter: CGFloat = 28
    
    @EnvironmentObject var themeSettings: ThemeSettings
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .fill(themeSettings.selectedThemePrimaryColor)
                    .frame(width: outerCircleDiameter, height: outerCircleDiameter, alignment: .center)
                Circle()
                    .fill(Color(.systemBackground))
                    .frame(width: innerCircleDiameter, height: innerCircleDiameter, alignment: .center)
            }
            Text(daySymbol)
                .foregroundColor(isCurrentDay ? themeSettings.selectedThemeSecondaryColor : Color(.label))
                .font(.subheadline)
        }
    }
}

// MARK: - Preview
struct DailyAdministrationView_Previews: PreviewProvider {
    static var previews: some View {
        DailyAdministrationView(daySymbol: "L", isCurrentDay: true)
            .environmentObject(ThemeSettings())
            .previewLayout(.sizeThatFits)
    }
}
