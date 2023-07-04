//
//  SettingsView.swift
//  Remedmind
//
//  Created by Davide Aliti on 17/01/23.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var themeSettings: ThemeSettings
    @EnvironmentObject var appearanceSettings: AppearanceSettings
    @EnvironmentObject var iconSettings: IconSettings
    @Binding var showSettingsModal: Bool
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    Section {
  
                        AppearancePickerView()
                            .environmentObject(self.appearanceSettings)
                            .environmentObject(self.themeSettings)
                        
                        ThemePickerView()
                            .environmentObject(self.themeSettings)
                        
                        IconPickerView()
                            .environmentObject(self.themeSettings)
                            .environmentObject(self.iconSettings)
                        
                    } header: {
                        Text("settingsView.style.title")
                    }
                    .padding(.vertical, 3)
                    
                    Section("About this application", content: {
                        SettingsFormRow(icon: "app.badge", title: "Application", content: "Remedminder")
                            .environmentObject(self.themeSettings)
                        SettingsFormRow(icon: "flag", title: "Version", content: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0")
                            .environmentObject(self.themeSettings)
                        SettingsFormRow(icon: "ipad.and.iphone", title: "Available on", content: "iPhone, iPad")
                            .environmentObject(self.themeSettings)
                        SettingsFormRow(icon: "pc", title: "Developed by", content: "Light Stimulus (Davide Aliti)")
                            .environmentObject(self.themeSettings)
                        SettingsFormRow(icon: "link", title: "Developer website", link: "https://github.com/Light2288")
                            .environmentObject(self.themeSettings)
                    })
                    .padding(.vertical, 3)
                    
                }
                .listStyle(.grouped)
                .environment(\.horizontalSizeClass, .regular)
                
                Text("© 2023 Light Stimulus\nAll right reserved")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(themeSettings.selectedThemePrimaryColor)
            }
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettingsModal = false
                    } label: {
                        Label("Close", systemImage: "xmark.circle")
                    }
                }
            }
        }
        .tint(themeSettings.selectedThemePrimaryColor)
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettingsModal: .constant(true))
            .environmentObject(AppearanceSettings())
            .environmentObject(ThemeSettings())
            .environmentObject(IconSettings())
    }
}
