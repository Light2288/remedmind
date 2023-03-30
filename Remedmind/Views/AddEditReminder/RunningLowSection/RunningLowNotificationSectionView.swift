//
//  RunningLowNotificationSectionView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/03/23.
//

import SwiftUI

struct RunningLowNotificationSectionView: View {
    // MARK: - Properties
    @Binding var reminder: ReminderModel
    
    // MARK: - Body
    var body: some View {
        Toggle(isOn: $reminder.activeRunningLowNotification) {
            Text("Ricevi una notifica quando la confezione sta per esaurirsi")
        }
        if reminder.activeRunningLowNotification {
            DatePicker("Orario della notifica", selection: $reminder.runningLowNotificationTime, displayedComponents: .hourAndMinute)
            HStack {
                Text("\(reminder.medicine.administrationType == .pill ? "Pillole" : "Bustine") in una confezione:")
                Spacer()
                TextField("", value: $reminder.medicine.packageQuantity, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                    .fixedSize()
                    .textFieldStyle(.roundedBorder)
            }
        }
    }
}

// MARK: - Preview
struct RunningLowNotificationSectionView_Previews: PreviewProvider {
    static var previews: some View {
        RunningLowNotificationSectionView(reminder: .constant(ReminderModel()))
    }
}
