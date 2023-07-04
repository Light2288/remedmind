//
//  IconPickerView.swift
//  Remedmind
//
//  Created by Davide Aliti on 04/07/23.
//

import SwiftUI

struct IconPickerView: View {
    // MARK: - Properties
    @EnvironmentObject var themeSettings: ThemeSettings
    @EnvironmentObject var iconSettings: IconSettings
    
    let icons: [Icon] = iconData
    
    
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text("settingsView.style.icons")
                .foregroundColor(Color(.systemGray))
            HStack(spacing: 40) {
                Spacer()
                ForEach(icons.filter({ icon in
                    icon.iconName.contains(themeSettings.selectedIconsId)
                }), id: \.self) { icon in
                    ZStack {
                        Button {
                            iconSettings.selectedIconId = icon.id
                        } label: {
                            Image(uiImage: UIImage(named: icon.iconName ) ?? UIImage())
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .cornerRadius(9)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 9)
                                        .stroke(Color(.systemGray2), lineWidth: 3)
                                )
                        }
                        .overlay(
                            iconSettings.selectedIconId == icon.id ? Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(themeSettings.selectedThemePrimaryColor)
                                    .background(
                                        Circle()
                                            .stroke(Color(UIColor.secondarySystemGroupedBackground), lineWidth: 4)
                                    )
                                    .offset(x: 30, y: 30) : nil
                        )
                        .buttonStyle(.borderless)
                        .onReceive([self.iconSettings.selectedIconId].publisher.first()) { (value) in
                            let currentIconIndex = self.icons.firstIndex(where: {$0.iconName == UIApplication.shared.alternateIconName}) ?? 0
                            if currentIconIndex != value {
                                UIApplication.shared.setAlternateIconName(self.iconSettings.selectedIconName) { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        print("Success! You have changed the app icon.")
                                    }
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .padding(.bottom, 8)
    }
}

// MARK: - Preview
struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerView()
            .environmentObject(ThemeSettings())
    }
}
