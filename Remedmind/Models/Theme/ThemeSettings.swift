//
//  ThemeSettings.swift
//  Remedmind
//
//  Created by Davide Aliti on 29/01/23.
//

import SwiftUI

class ThemeSettings: ObservableObject {
    @Published var selectedThemeIndex: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.selectedThemeIndex, forKey: "Theme")
        }
    }
    
    var selectedThemePrimaryColor: Color {
        themeData[self.selectedThemeIndex].themeColors.primaryColor
    }
    
    var selectedThemeSecondaryColor: Color {
        themeData[self.selectedThemeIndex].themeColors.secondaryColor
    }
}
