//
//  NotificationsInfoView.swift
//  Remedmind
//
//  Created by Davide Aliti on 12/03/23.
//

import SwiftUI

struct NotificationsInfoView: View {
    // MARK: - Properties
    var reminder: Reminder
    @State private var isExpanded: Bool = false
    
    // MARK: - Body
    var body: some View {
        DisclosureGroup("Notifiche", isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Notifiche assunzione: \(reminder.activeAdministrationNotification ? "Attive" : "Non attive")")
                    .font(.subheadline)
                    .padding(.top, 8)
                Text("Notifiche esaurimento confezione: \(reminder.activeRunningLowNotification ? "Attive" : "Non attive")")
                    .font(.subheadline)
                if reminder.activeRunningLowNotification {
                    Text("Pillole in una confezione: \(reminder.packageQuantity)")
                        .font(.subheadline)
                    Text("Pillole rimanenti nella confezione attuale: \(reminder.currentPackageQuantity)")
                        .font(.subheadline)
                }
            }
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
