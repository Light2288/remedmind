//
//  AdministrationDaysButtonsView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/03/23.
//

import SwiftUI

struct AdministrationDaysButtonsView: View {
    // MARK: - Properties
    @Binding var reminder: ReminderModel
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var localizedVeryShortWeekdaysSymbols: [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: Locale.preferredLanguages[0])
        return Array(calendar.veryShortWeekdaySymbols[calendar.firstWeekday - 1 ..< calendar.veryShortWeekdaySymbols.count] + calendar.veryShortWeekdaySymbols[0 ..< calendar.firstWeekday - 1])
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("Seleziona i giorni di assunzione".uppercased())
                .font(.footnote)
            HStack {
                Spacer()
                ForEach(Array(reminder.medicine.administrationDays.enumerated()), id: \.offset) { index, _ in
                    Toggle(
                        isOn: $reminder.medicine.administrationDays[index]) {
                            Text(localizedVeryShortWeekdaysSymbols[index].prefix(1))
                                .font(.footnote)
                        }
                        .toggleStyle(.button)
                        .tint(themeSettings.selectedThemePrimaryColor)
                }
                Spacer()
            }
        }
    }
}

// MARK: - Preview
struct AdministrationDaysButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrationDaysButtonsView(reminder: .constant(ReminderModel()))
            .environmentObject(ThemeSettings())
    }
}
