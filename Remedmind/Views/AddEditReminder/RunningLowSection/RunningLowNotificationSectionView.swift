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
            Text("addEditReminderView.packageExhaustion.runningLowNotifications.label")
        }
        if reminder.activeRunningLowNotification {
            DatePicker(String(localized: "addEditReminderView.packageExhaustion.runningLowNotifications.time.label"), selection: $reminder.runningLowNotificationTime, displayedComponents: .hourAndMinute)
        }
    }
}

// MARK: - Preview
struct RunningLowNotificationSectionView_Previews: PreviewProvider {
    static var previews: some View {
        RunningLowNotificationSectionView(reminder: .constant(ReminderModel()))
    }
}
