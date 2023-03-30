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
        DisclosureGroup("Notifiche", isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Notifiche assunzione: \(reminder.activeAdministrationNotification ? "Attive" : "Non attive")")
                    .padding(.top, 8)
                Text("Notifiche esaurimento confezione: \(reminder.activeRunningLowNotification ? "Attive" : "Non attive")")
                if reminder.activeRunningLowNotification {
                    Text("Pillole in una confezione: \(reminder.packageQuantity)")
                    Text("Pillole rimanenti nella confezione attuale: \(reminder.currentPackageQuantity.formatted(.number))")
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
