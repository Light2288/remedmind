//
//  AdministrationQuantityStepperView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/03/23.
//

import SwiftUI

struct AdministrationQuantityStepperView: View {
    // MARK: - Properties
    @Binding var reminder: ReminderModel
    @FocusState var focusedField: Field?
    
    // MARK: - Body
    var body: some View {
        Picker(selection: $reminder.medicine.administrationType) {
            ForEach(AdministrationType.allCases, id: \.self)
            { administrationType in
                Text(administrationType.administrationTypeShortDescription)
            }
        } label: {
            Text("addEditReminderView.administration.administrationType.label")
        }
        .onChange(of: reminder.medicine.administrationType) { _ in
            focusedField = nil
            if !reminder.medicine.administrationType.canRunLow {
                reminder.activeRunningLowNotification = false
            }
            if !reminder.medicine.administrationType.hasIntakeQuantity {
                reminder.medicine.administrationQuantity = 1.0
            }
        }
        if reminder.medicine.administrationType.hasIntakeQuantity {
            Stepper(value: $reminder.medicine.administrationQuantity, in: 0 ... .infinity, step: 0.5) {
                HStack(spacing: 0) {
                    Text("addEditReminderView.administration.administrationQuantity.label \(reminder.medicine.administrationQuantity.description)")
                    Text(" " + (reminder.medicine.administrationQuantity <= 1.0 ? reminder.medicine.administrationType.administrationTypeShortDescription : reminder.medicine.administrationType.administrationTypeDescriptionPlural))
                    
                }
            }
            .onChange(of: reminder.medicine.administrationQuantity) { _ in
                focusedField = nil
            }
        }
    }
}

// MARK: - Preview
struct AdministrationQuantityStepperView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrationQuantityStepperView(reminder: .constant(ReminderModel()))
    }
}
