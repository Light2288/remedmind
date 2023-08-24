//
//  IntakeNotificationAutoModeLabelView.swift
//  Remedmind
//
//  Created by Davide Aliti on 22/08/23.
//

import SwiftUI

struct IntakeNotificationModeLabelView: View {
    // MARK: - Properties
    @AppStorage("intakeNotificationType") var intakeNotificationType: IntakeNotificationType = .automatic
    
    // MARK: - Body
    var body: some View {
        switch intakeNotificationType {
        case .automatic:
            Text("settingsView.notifications.intakeNotification.autoMode.label")
                .font(.footnote)
        case .custom:
            Text("settingsView.notifications.intakeNotification.customMode.label")
                .font(.footnote)
        }
    }
}

// MARK: - Preview
struct IntakeNotificationAutoModeLabelView_Previews: PreviewProvider {
    static var previews: some View {
        IntakeNotificationModeLabelView()
    }
}
