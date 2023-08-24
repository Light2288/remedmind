//
//  NotificationSectionView.swift
//  Remedmind
//
//  Created by Davide Aliti on 21/08/23.
//

import SwiftUI

struct NotificationsSectionView: View {
    // MARK: - Properties
    
    // MARK: - Body
    var body: some View {
        Section("settingsView.notifications.intakeNotificationsTitle", content: {
            IntakeNotificationsSettingsView()
        })
        .padding(.vertical, 3)
        Section("settingsView.notifications.packageExhaustionNotificationsTitle", content: {
            PackageExhaustionNotificationsSettingsView()
        })
        .padding(.vertical, 3)
    }
}

// MARK: - Preview
struct NotificationSectionView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsSectionView()
    }
}
