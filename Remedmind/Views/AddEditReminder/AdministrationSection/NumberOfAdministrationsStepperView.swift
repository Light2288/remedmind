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
    
    // MARK: - Body
    var body: some View {
        Stepper("Dosi giornaliere: \(reminder.medicine.numberOfAdministrations)", value: $reminder.medicine.numberOfAdministrations)
            .onChange(of: reminder.medicine.numberOfAdministrations) { newValue in
                if reminder.administrationNotificationTimes.count < newValue {
                    let newNotificationTimes = Array(repeating: Date.now, count: Int(newValue) - reminder.administrationNotificationTimes.count)
                    reminder.administrationNotificationTimes.append(contentsOf: newNotificationTimes)
                } else {
                    reminder.administrationNotificationTimes.removeLast(reminder.administrationNotificationTimes.count - Int(newValue))
                }
            }
    }
}

// MARK: - Preview
struct NumberOfAdministrationsStepperView_Previews: PreviewProvider {
    static var previews: some View {
        NumberOfAdministrationsStepperView(reminder: .constant(ReminderModel()))
    }
}
