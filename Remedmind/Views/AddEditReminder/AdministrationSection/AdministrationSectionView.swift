//
//  AdministrationSectionView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/03/23.
//

import SwiftUI

struct AdministrationSectionView: View {
    // MARK: - Properties
    @Binding var reminder: ReminderModel
    @EnvironmentObject var themeSettings: ThemeSettings
    @FocusState var focusedField: Field?
    
    // MARK: - Body
    var body: some View {
        Section {
            AdministrationFrequencyPickerView(reminder: $reminder, focusedField: _focusedField)
            
            if reminder.medicine.administrationFrequency == .weekly {
                AdministrationDaysButtonsView(reminder: $reminder)
            }
            
            NumberOfAdministrationsStepperView(reminder: $reminder, focusedField: _focusedField)
            
            AdministrationQuantityStepperView(reminder: $reminder, focusedField: _focusedField)
            
            AdministrationNotificationsSectionView(reminder: $reminder, focusedField: _focusedField)
        } header: {
            Text("addEditReminderView.administration.title")
        }
    }
}

// MARK: - Preview
struct AdministrationSectionView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            AdministrationSectionView(reminder: .constant(ReminderModel()))
        }
    }
}
