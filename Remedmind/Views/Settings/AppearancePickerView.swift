//
//  AppearancePickerView.swift
//  Remedmind
//
//  Created by Davide Aliti on 04/07/23.
//

import SwiftUI

struct AppearancePickerView: View {
    // MARK: - Properties
    @EnvironmentObject var appearanceSettings: AppearanceSettings
    @EnvironmentObject var themeSettings: ThemeSettings
    
    let appearances: [Appearance] = appearanceData
    
    // MARK: - Body
    var body: some View {
        Picker(selection: $appearanceSettings.selectedAppearanceIndex) {
            ForEach(0..<appearances.count, id: \.self) { index in
                Text(appearances[index].appearanceName)
            }
        } label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(themeSettings.selectedThemeSecondaryColor)
                    Image(systemName: "circle.righthalf.filled")
                        .resizable()
                        .scaledToFit()
                        .padding(6)
                        .foregroundColor(Color(.systemBackground))
                }
                .frame(width: 44, height: 44)
                Text("settingsView.style.appearance")
                    .foregroundColor(Color(.systemGray))
            }
        }
        .onChange(of: appearanceSettings.selectedAppearanceIndex, perform: { value in
            let scenes = UIApplication.shared.connectedScenes
            let windowScenes = scenes.first as? UIWindowScene
            let window = windowScenes?.windows.first
            window?.overrideUserInterfaceStyle = appearanceSettings.selectedAppearance
        })
    }
}

// MARK: - Preview
struct AppearancePickerView_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePickerView()
            .environmentObject(AppearanceSettings())
            .environmentObject(ThemeSettings())
    }
}
