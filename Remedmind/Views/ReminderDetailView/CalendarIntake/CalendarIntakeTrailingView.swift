//
//  CalendarIntakeTrailingView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/02/23.
//

import SwiftUI

struct CalendarIntakeTrailingView: View {
    // MARK: - Properties
    let frameHeight: CGFloat = 35
    var calendar: Calendar
    var day: Date
    
    @EnvironmentObject var themeSettings: ThemeSettings
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Text(DateFormatter.dayFormatter.string(from: day))
                .foregroundColor(.secondary)
                .frame(height: frameHeight)
            if calendar.isDateInToday(day) {
                Circle()
                    .foregroundColor(themeSettings.selectedThemePrimaryColor)
                    .frame(width: 4, height: 4)
                    .offset(x: 0, y: 10)
            }
        }
        
    }
}

// MARK: - Preview
struct CalendarIntakeTrailingView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarIntakeTrailingView(calendar: Calendar(identifier: .gregorian), day: Date.now)
            .environmentObject(ThemeSettings())
    }
}
