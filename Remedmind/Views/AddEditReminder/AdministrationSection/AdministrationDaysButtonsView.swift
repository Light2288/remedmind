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
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text(String(localized: "addEditReminderView.administration.selectAdministrationDays.label").uppercased())
                .font(.footnote)
            HStack {
                Spacer()
                ForEach(Array(reminder.medicine.administrationDays.enumerated()), id: \.offset) { index, _ in
                    Toggle(
                        isOn: $reminder.medicine.administrationDays[index]) {
                            Text(Calendar.localizedVeryShortWeekdaysSymbols[index].prefix(1))
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
