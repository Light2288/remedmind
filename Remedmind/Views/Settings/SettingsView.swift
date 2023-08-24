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
    @Binding var showSettingsModal: Bool
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    StyleSectionView()
                    NotificationsSectionView()
                    AboutThisAppSectionView()
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
