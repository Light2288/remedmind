//
//  WeekAdministrationView.swift
//  Remedmind
//
//  Created by Davide Aliti on 09/02/23.
//

import SwiftUI

struct WeekAdministrationView: View {
    // MARK: - Properties
    @EnvironmentObject var themeSettings: ThemeSettings

    var localizedVeryShortWeekdaysSymbols: [String] = Array(Calendar.current.veryShortWeekdaySymbols[Calendar.current.firstWeekday - 1 ..< Calendar.current.veryShortWeekdaySymbols.count] + Calendar.current.veryShortWeekdaySymbols[0 ..< Calendar.current.firstWeekday - 1])
    var isCurrentDay: [Bool] {
        Calendar.current.weekdaySymbols.enumerated().map { $0.0 == Calendar.current.component(.weekday, from: Date()) - 1}
    }
    var localizedIsCurrentDay: [Bool] {
        Array(isCurrentDay[Calendar.current.firstWeekday - 1 ..< Calendar.current.veryShortWeekdaySymbols.count] + isCurrentDay[0 ..< Calendar.current.firstWeekday - 1])
    }

    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(0..<7, id: \.self) { index in
                DailyAdministrationView(daySymbol: localizedVeryShortWeekdaysSymbols[index], isCurrentDay: localizedIsCurrentDay[index])
                    .environmentObject(self.themeSettings)
            }
        }
    }
}

// MARK: - Preview
struct WeekAdministrationView_Previews: PreviewProvider {
    static var previews: some View {
        WeekAdministrationView()
            .environmentObject(ThemeSettings())
            .previewLayout(.sizeThatFits)
    }
}
