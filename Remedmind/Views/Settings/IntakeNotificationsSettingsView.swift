//
//  IntakeNotificationsSettingsView.swift
//  Remedmind
//
//  Created by Davide Aliti on 21/08/23.
//

import SwiftUI

struct IntakeNotificationsSettingsView: View {
    // MARK: - Properties
    @AppStorage("intakeNotificationType") var intakeNotificationType: IntakeNotificationType = .automatic
    
    
    // MARK: - Body
    var body: some View {
        IntakeNotificationsModePickerView()
        IntakeNotificationModeLabelView()
        if intakeNotificationType == .custom {
            IntakeNotificationTimePickerView()
        }
    }
}

// MARK: - Preview
struct IntakeNotificationsSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        IntakeNotificationsSettingsView()
    }
}
