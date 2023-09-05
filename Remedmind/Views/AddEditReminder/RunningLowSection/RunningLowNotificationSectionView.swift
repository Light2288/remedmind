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
    @AppStorage("packageExhaustionNotificationDefaultTime") var packageExhaustionNotificationDefaultTimeShadow: Double = 0
    
    // MARK: - Body
    var body: some View {
        Toggle(isOn: $reminder.activeRunningLowNotification) {
            Text("addEditReminderView.packageExhaustion.runningLowNotifications.label")
        }
        if reminder.activeRunningLowNotification {
            DatePicker(String(localized: "addEditReminderView.packageExhaustion.runningLowNotifications.time.label"), selection: $reminder.runningLowNotificationTime, displayedComponents: .hourAndMinute)
                .onAppear {
                    guard packageExhaustionNotificationDefaultTimeShadow != 0 else {
                        var dateComponents = DateComponents()
                        dateComponents.hour = 18
                        dateComponents.minute = 00
                        reminder.runningLowNotificationTime = Calendar.customLocalizedCalendar.date(from: dateComponents) ?? Date.now
                        return
                    }
                    reminder.runningLowNotificationTime = Date(rawValue: packageExhaustionNotificationDefaultTimeShadow)
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
