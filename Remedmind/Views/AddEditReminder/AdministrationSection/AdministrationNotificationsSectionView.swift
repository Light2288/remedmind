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
    
    var ordinalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter
    }()
    
    // MARK: - Body
    var body: some View {
        Toggle(isOn: $reminder.activeAdministrationNotification) {
            Text("addEditReminderView.administration.administrationNotifications.label")
        }
        .onChange(of: reminder.activeAdministrationNotification) { _ in
            focusedField = nil
        }
        if reminder.activeAdministrationNotification {
            ForEach(Array(reminder.administrationNotificationTimes.enumerated()), id: \.offset) { index, _ in
                DatePicker("addEditReminderView.administration.administrationNotificationsTimes.label \(ordinalFormatter.string(from: index+1 as NSNumber) ?? "")", selection: $reminder.administrationNotificationTimes[index], displayedComponents: .hourAndMinute)
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
