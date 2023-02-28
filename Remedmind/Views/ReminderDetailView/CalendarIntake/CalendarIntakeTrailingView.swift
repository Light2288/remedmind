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
    
    var dayFormatter: DateFormatter {
        DateFormatter(dateFormat: "d", calendar: calendar)
    }
    
    // MARK: - Body
    var body: some View {
        Text(dayFormatter.string(from: day))
            .foregroundColor(.secondary)
            .frame(height: frameHeight)
    }
}

// MARK: - Preview
struct CalendarIntakeTrailingView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarIntakeTrailingView(calendar: Calendar(identifier: .gregorian), day: Date.now)
    }
}
