//
//  PackageExhaustionNotificationTimePickerView.swift
//  Remedmind
//
//  Created by Davide Aliti on 22/08/23.
//

import SwiftUI

struct PackageExhaustionNotificationTimePickerView: View {
    // MARK: - Properties
    @EnvironmentObject var themeSettings: ThemeSettings
    @AppStorage("packageExhaustionNotificationDefaultTime") var packageExhaustionNotificationDefaultTimeShadow: Double = 0
    @State var packageExhaustionNotificationDefaultTime: Date = Date.now
    
    // MARK: - Body
    var body: some View {
        DatePicker(selection: $packageExhaustionNotificationDefaultTime, displayedComponents: .hourAndMinute) {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(themeSettings.selectedThemeSecondaryColor)
                    Image(systemName: "clock.badge.exclamationmark")
                        .resizable()
                        .scaledToFit()
                        .padding(6)
                        .foregroundColor(Color(.systemBackground))
                }
                .frame(width: 44, height: 44)
                Text("settingsView.notifications.packageExhaustionNotification.timePicker.label")
                    .foregroundColor(Color(.systemGray))
            }
        }
        .onChange(of: packageExhaustionNotificationDefaultTime) { newValue in
            packageExhaustionNotificationDefaultTimeShadow = newValue.rawValue
        }
        .onAppear {
            guard packageExhaustionNotificationDefaultTimeShadow != 0 else {
                var dateComponents = DateComponents()
                dateComponents.hour = 18
                dateComponents.minute = 00
                packageExhaustionNotificationDefaultTime = Calendar.customLocalizedCalendar.date(from: dateComponents) ?? Date.now
                return
            }
            packageExhaustionNotificationDefaultTime = Date(rawValue: packageExhaustionNotificationDefaultTimeShadow)
        }
    }
}

// MARK: - Preview
struct PackageExhaustionNotificationTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        PackageExhaustionNotificationTimePickerView()
    }
}
