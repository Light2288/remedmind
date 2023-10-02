//
//  NoIntakeDayView.swift
//  Remedmind
//
//  Created by Davide Aliti on 02/05/23.
//

import SwiftUI

struct NoIntakeDayView: View {
    // MARK: - Properties
    let text: String
    let frameSize: CGFloat
    var day: Date
    var font: Font = .body
    
    @EnvironmentObject var themeSettings: ThemeSettings
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Text(text)
                .font(font)
                .foregroundColor(.secondary)
                .frame(width: frameSize, height: frameSize)
            if Calendar.customLocalizedCalendar.isDateInToday(day) {
                Circle()
                    .foregroundColor(themeSettings.selectedThemePrimaryColor)
                    .frame(width: 4, height: 4)
                    .offset(x: 0, y: 10)
            }
        }
        
    }
}

// MARK: - Preview
struct NoIntakeDayView_Previews: PreviewProvider {
    static var previews: some View {
        NoIntakeDayView(text: DateFormatter.weekDayFormatter.string(from: Date.now), frameSize: 35, day: Date.now)
            .environmentObject(ThemeSettings())
    }
}
