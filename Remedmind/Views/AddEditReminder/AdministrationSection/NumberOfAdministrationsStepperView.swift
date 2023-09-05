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
    @AppStorage("intakeNotificationType") var intakeNotificationType: IntakeNotificationType = .automatic
    @AppStorage("intakeNotificationDefaultTime") var intakeNotificationDefaultTimeShadow: Double = 0
    
    // MARK: - Body
    var body: some View {
        Stepper("addEditReminderView.administration.numberOfAdministrations.label \(reminder.medicine.numberOfAdministrations)", value: $reminder.medicine.numberOfAdministrations, in: 1 ... Int32.max)
            .onChange(of: reminder.medicine.numberOfAdministrations) { newValue in
                reminder.administrationNotificationTimes.removeAll()
                reminder.createAdministrationNotificationTimes(intakeNotificationType, startingAt: intakeNotificationDefaultTimeShadow)
                focusedField = nil
            }
            .onAppear {
                reminder.createAdministrationNotificationTimes(intakeNotificationType, startingAt: intakeNotificationDefaultTimeShadow)
            }
    }
}

// MARK: - Preview
struct NumberOfAdministrationsStepperView_Previews: PreviewProvider {
    static var previews: some View {
        NumberOfAdministrationsStepperView(reminder: .constant(ReminderModel()))
    }
}
