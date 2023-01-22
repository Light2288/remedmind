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
    @Binding var showSettingsModal: Bool
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    Section("About this application", content: {
                        SettingsFormRow(icon: "app.badge", title: "Application", content: "Remedminder")
                        SettingsFormRow(icon: "flag", title: "Version", content: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0")
                        SettingsFormRow(icon: "laptopcomputer.and.iphone", title: "Available on", content: "iPhone, iPad, Mac")
                        SettingsFormRow(icon: "pc", title: "Developed by", content: "Light Stimulus (Davide Aliti)")
                        SettingsFormRow(icon: "link", title: "Developer website", link: "https://github.com/Light2288")
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
                    .foregroundColor(.accentColor)
            }
            .background(Color(colorScheme == .dark ? .black : .systemGray6).edgesIgnoringSafeArea(.all))
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
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettingsModal: .constant(true))
    }
}
