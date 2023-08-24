//
//  PackageExhaustionNotificationsSettingsView.swift
//  Remedmind
//
//  Created by Davide Aliti on 22/08/23.
//

import SwiftUI

struct PackageExhaustionNotificationsSettingsView: View {
    // MARK: - Properties
    
    // MARK: - Body
    var body: some View {
        PackageExhaustionNotificationTimePickerView()
    }
}

// MARK: - Preview
struct PackageExhaustionNotificationsSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PackageExhaustionNotificationsSettingsView()
    }
}
