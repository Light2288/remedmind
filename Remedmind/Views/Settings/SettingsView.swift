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
    @EnvironmentObject var iconSettings: IconNames
    @EnvironmentObject var themeSettings: ThemeSettings
    @Binding var showSettingsModal: Bool
    
    let themes: [Theme] = themeData
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    Section {
                        Picker(selection: $iconSettings.currentIndex) {
                            ForEach(0..<iconSettings.iconNames.count, id: \.self) { index in
                                HStack(spacing: 20) {
                                    Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Multicolor") ?? UIImage())
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .cornerRadius(9)
                                    Text(self.iconSettings.iconNames[index] ?? "Multicolor")
                                }
                            }
                        } label: {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                                        .fill(themeSettings.selectedThemeSecondaryColor)
                                    Image(systemName: "paintbrush")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(6)
                                        .foregroundColor(Color(.systemBackground))
                                }
                                .frame(width: 44, height: 44)
                                Text("App icon")
                                    .foregroundColor(Color(.systemGray))
                            }
                        }
                        .onReceive([self.iconSettings.currentIndex].publisher.first()) { (value) in
                            let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                            if index != value {
                                UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        print("Success! You have changed the app icon.")
                                    }
                                }
                            }
                        }
                        
                        Picker(selection: $themeSettings.selectedThemeIndex) {
                            ForEach(0..<themes.count, id: \.self) { index in
                                HStack(spacing: 20) {
                                    Text(themes[index].themeName)
                                }
                            }
                        } label: {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                                        .fill(themeSettings.selectedThemeSecondaryColor)
                                    Image(systemName: "paintpalette")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(6)
                                        .foregroundColor(Color(.systemBackground))
                                }
                                .frame(width: 44, height: 44)
                                Text("Theme")
                                    .foregroundColor(Color(.systemGray))
                            }
                        }

                    } header: {
                        Text("Appearance")
                    }
                    .padding(.vertical, 3)
                    
                    Section("About this application", content: {
                        SettingsFormRow(icon: "app.badge", title: "Application", content: "Remedminder")
                            .environmentObject(self.themeSettings)
                        SettingsFormRow(icon: "flag", title: "Version", content: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0")
                            .environmentObject(self.themeSettings)
                        SettingsFormRow(icon: "laptopcomputer.and.iphone", title: "Available on", content: "iPhone, iPad, Mac")
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
                        Label("Close", systemImage: "xmark.circle.fill")
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
            .environmentObject(IconNames())
            .environmentObject(ThemeSettings())
    }
}
