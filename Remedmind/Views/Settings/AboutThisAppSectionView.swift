//
//  AboutThisAppSectionView.swift
//  Remedmind
//
//  Created by Davide Aliti on 17/08/23.
//

import SwiftUI

struct AboutThisAppSectionView: View {
    // MARK: - Properties
    @EnvironmentObject var themeSettings: ThemeSettings

    // MARK: - Body
    var body: some View {
        Section("settingsView.aboutThisApp.title", content: {
            SettingsFormRow(icon: "app.badge", title: "settingsView.aboutThisApp.application", content: "Remedmind")
                .environmentObject(self.themeSettings)
            SettingsFormRow(icon: "flag", title: "settingsView.aboutThisApp.version", content: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0")
                .environmentObject(self.themeSettings)
            SettingsFormRow(icon: "ipad.and.iphone", title: "settingsView.aboutThisApp.availableOn", content: "iPhone, iPad")
                .environmentObject(self.themeSettings)
            SettingsFormRow(icon: "pc", title: "settingsView.aboutThisApp.developedBy", content: "Light Stimulus (Davide Aliti)")
                .environmentObject(self.themeSettings)
            SettingsFormRow(icon: "link", title: "settingsView.aboutThisApp.developerWebsite", link: "https://github.com/Light2288")
                .environmentObject(self.themeSettings)
        })
        .padding(.vertical, 3)
    }
}

// MARK: - Preview
struct AboutThisAppSectionView_Previews: PreviewProvider {
    static var previews: some View {
        AboutThisAppSectionView()
    }
}
