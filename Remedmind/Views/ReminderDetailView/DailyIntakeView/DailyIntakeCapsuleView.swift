//
//  DailyIntakeCapsuleView.swift
//  Remedmind
//
//  Created by Davide Aliti on 02/03/23.
//

import SwiftUI

struct DailyIntakeCapsuleView: View {
    // MARK: - Properties
    let height: CGFloat
    @EnvironmentObject var themeSettings: ThemeSettings

    
    // MARK: - Body
    var body: some View {
        Capsule(style: .continuous)
            .stroke(themeSettings.selectedThemePrimaryColor, style: StrokeStyle(lineWidth: 1))
            .frame(height: height)
    }
}

// MARK: - Preview
struct DailyIntakeCapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        DailyIntakeCapsuleView(height: 120)
            .environmentObject(ThemeSettings())
    }
}
