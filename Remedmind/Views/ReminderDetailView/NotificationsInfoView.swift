//
//  NotificationsInfoView.swift
//  Remedmind
//
//  Created by Davide Aliti on 12/03/23.
//

import SwiftUI

struct NotificationsInfoView: View {
    // MARK: - Properties
    @ObservedObject var reminder: Reminder
    @State private var isExpanded: Bool = false
    
    // MARK: - Body
    var body: some View {
        DisclosureGroup("detailView.notifications.title", isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 8) {
                Text("detailView.notifications.activeAdministrationNotifications \(reminder.activeAdministrationNotification ? String(localized: "label.active") : String(localized: "label.notActive"))")
                    .padding(.top, 8)
                if reminder.activeAdministrationNotification {
                    Text("detailView.notifications.administrationNotificationsTimes \(reminder.administrationNotificationsTimesString)")
                }
                Text("detailView.notifications.activeRunningLowNotifications \(reminder.activeRunningLowNotification ? String(localized: "label.active") : String(localized: "label.notActive"))")
                if reminder.activeRunningLowNotification {
                    Text("detailView.notifications.runningLowNotificationsTime \(reminder.runningLowNotificationsTimeString)")
                    Text("detailView.notifications.packageQuantity \(reminder.administrationTypeString.capitalizedFirstLetter) \(reminder.packageQuantity)")
                    Text("detailView.notifications.currentPackageQuantity \(reminder.administrationTypeString.capitalizedFirstLetter) \(reminder.currentPackageQuantity.formatted(.number))")
                }
            }
            .font(.subheadline)
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .leading
            )
        }
        .padding(.horizontal)
    }
}

// MARK: - Preview
struct NotificationsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsInfoView(reminder: Reminder(context: PersistenceController.preview.container.viewContext))
    }
}
