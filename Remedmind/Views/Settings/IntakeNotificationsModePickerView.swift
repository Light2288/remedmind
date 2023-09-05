//
//  IntakeNotifiicationsModePickerView.swift
//  Remedmind
//
//  Created by Davide Aliti on 22/08/23.
//

import SwiftUI

struct IntakeNotificationsModePickerView: View {
    // MARK: - Properties
    @AppStorage("intakeNotificationType") var intakeNotificationType: IntakeNotificationType = .automatic
    @EnvironmentObject var themeSettings: ThemeSettings
    
    // MARK: - Body
    var body: some View {
        Picker(selection: $intakeNotificationType) {
            ForEach(IntakeNotificationType.allCases, id: \.self) { notificationType in
                Text("\(notificationType.intakeNotificationTypeDescription.capitalizedFirstLetter)").tag(notificationType)
            }
        } label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(themeSettings.selectedThemeSecondaryColor)
                    Image(systemName: "person.badge.clock")
                        .resizable()
                        .scaledToFit()
                        .padding(6)
                        .foregroundColor(Color(.systemBackground))
                }
                .frame(width: 44, height: 44)
                Text("settingsView.notifications.intakeNotification.label")
                    .foregroundColor(Color(.systemGray))
            }
        }
    }
}

// MARK: - Preview
struct IntakeNotifiicationsModePickerView_Previews: PreviewProvider {
    static var previews: some View {
        IntakeNotificationsModePickerView()
    }
}
