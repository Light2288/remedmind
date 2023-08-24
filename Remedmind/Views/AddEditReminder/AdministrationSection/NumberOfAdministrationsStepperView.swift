//
//  NumberOfAdministrationsView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/03/23.
//

import SwiftUI

struct NumberOfAdministrationsStepperView: View {
    // MARK: - Properties
    @Binding var reminder: ReminderModel
    @FocusState var focusedField: Field?
    
    // MARK: - Body
    var body: some View {
        Stepper("addEditReminderView.administration.numberOfAdministrations.label \(reminder.medicine.numberOfAdministrations)", value: $reminder.medicine.numberOfAdministrations, in: 1 ... Int32.max)
            .onChange(of: reminder.medicine.numberOfAdministrations) { newValue in
                if reminder.administrationNotificationTimes.count < newValue {
                    let newNotificationTimes = Array(repeating: Date.now, count: Int(newValue) - reminder.administrationNotificationTimes.count)
                    reminder.administrationNotificationTimes.append(contentsOf: newNotificationTimes)
                } else {
                    reminder.administrationNotificationTimes.removeLast(reminder.administrationNotificationTimes.count - Int(newValue))
                }
                focusedField = nil
            }
    }
}

// MARK: - Preview
struct NumberOfAdministrationsStepperView_Previews: PreviewProvider {
    static var previews: some View {
        NumberOfAdministrationsStepperView(reminder: .constant(ReminderModel()))
    }
}
