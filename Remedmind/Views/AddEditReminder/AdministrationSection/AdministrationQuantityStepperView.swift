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
    
    // MARK: - Body
    var body: some View {
        Stepper(value: $reminder.medicine.administrationQuantity, in: 0 ... .infinity, step: 0.5) {
            HStack(spacing: 0) {
                Text("Dose: \(reminder.medicine.administrationQuantity.description)")
                Picker("", selection: $reminder.medicine.administrationType) {
                    ForEach(AdministrationType.allCases, id: \.self)
                    { administrationType in
                        Text(administrationType.rawValue).tag(administrationType)
                    }
                }
                .labelsHidden()
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
