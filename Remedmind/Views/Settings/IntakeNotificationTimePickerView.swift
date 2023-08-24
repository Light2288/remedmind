//
//  IntakeNotificationTimePickerView.swift
//  Remedmind
//
//  Created by Davide Aliti on 22/08/23.
//

import SwiftUI

struct IntakeNotificationTimePickerView: View {
    // MARK: - Properties
    @EnvironmentObject var themeSettings: ThemeSettings
    @AppStorage("intakeNotificationDefaultTime") var intakeNotificationDefaultTimeShadow: Double = 0
    @State var intakeNotificationDefaultTime: Date = Date.now
    
    // MARK: - Body
    var body: some View {
        DatePicker(selection: $intakeNotificationDefaultTime, displayedComponents: .hourAndMinute) {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(themeSettings.selectedThemeSecondaryColor)
                    Image(systemName: "clock.badge.checkmark")
                        .resizable()
                        .scaledToFit()
                        .padding(6)
                        .foregroundColor(Color(.systemBackground))
                }
                .frame(width: 44, height: 44)
                Text("settingsView.notifications.intakeNotification.timePicker.label")
                    .foregroundColor(Color(.systemGray))
            }
        }
        .onChange(of: intakeNotificationDefaultTime) { newValue in
            intakeNotificationDefaultTimeShadow = newValue.rawValue
        }
        .onAppear {
            guard intakeNotificationDefaultTimeShadow != 0 else {
                var dateComponents = DateComponents()
                dateComponents.hour = 8
                dateComponents.minute = 00
                intakeNotificationDefaultTime = Calendar.customLocalizedCalendar.date(from: dateComponents) ?? Date.now
                return
            }
            intakeNotificationDefaultTime = Date(rawValue: intakeNotificationDefaultTimeShadow)
        }
    }
}

// MARK: - Preview
struct IntakeNotificationTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        IntakeNotificationTimePickerView()
    }
}
