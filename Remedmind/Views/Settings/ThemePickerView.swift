//
//  ThemePickerView.swift
//  Remedmind
//
//  Created by Davide Aliti on 04/07/23.
//

import SwiftUI

struct ThemePickerView: View {
    // MARK: - Properties
    @EnvironmentObject var themeSettings: ThemeSettings
    
    let themes: [Theme] = themeData
    
    // MARK: - Body
    var body: some View {
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
                Text("settingsView.style.theme")
                    .foregroundColor(Color(.systemGray))
            }
        }
    }
}

// MARK: - Preview
struct ThemePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ThemePickerView()
            .environmentObject(ThemeSettings())
    }
}
