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
    
    // MARK: - Body
    var body: some View {
        Section {
            AdministrationFrequencyPickerView(reminder: $reminder)
            
            if reminder.medicine.administrationFrequency == .weekly {
                AdministrationDaysButtonsView(reminder: $reminder)
            }
            
            NumberOfAdministrationsStepperView(reminder: $reminder)
            
            AdministrationQuantityStepperView(reminder: $reminder)
            
            AdministrationNotificationsSectionView(reminder: $reminder)
        } header: {
            Text("Frequenza somministrazione e dosaggio")
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
