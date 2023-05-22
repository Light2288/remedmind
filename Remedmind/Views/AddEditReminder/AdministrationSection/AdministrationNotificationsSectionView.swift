//
//  AdministrationNotificationsSectionView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/03/23.
//

import SwiftUI

struct AdministrationNotificationsSectionView: View {
    // MARK: - Properties
    @Binding var reminder: ReminderModel
    @FocusState var focusedField: Field?
    
    // MARK: - Body
    var body: some View {
        Toggle(isOn: $reminder.activeAdministrationNotification) {
            Text("Ricevi una notifica per ricordarti di assumere la medicina")
        }
        .onChange(of: reminder.activeAdministrationNotification) { _ in
            focusedField = nil
        }
        if reminder.activeAdministrationNotification {
            ForEach(Array(reminder.administrationNotificationTimes.enumerated()), id: \.offset) { index, _ in
                DatePicker("Orario della notifica per la dose \(index+1)", selection: $reminder.administrationNotificationTimes[index], displayedComponents: .hourAndMinute)
            }
        }
    }
}

// MARK: - Preview
struct AdministrationNotificationsSectionView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrationNotificationsSectionView(reminder: .constant(ReminderModel()))
    }
}
