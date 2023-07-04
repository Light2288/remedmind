//
//  Appearance.swift
//  Remedmind
//
//  Created by Davide Aliti on 26/06/23.
//

import SwiftUI

class AppearanceSettings: ObservableObject {
    @Published var selectedAppearanceIndex: Int = UserDefaults.standard.integer(forKey: "Appearance") {
        didSet {
            UserDefaults.standard.set(self.selectedAppearanceIndex, forKey: "Appearance")
        }
    }
    
    var selectedAppearance: UIUserInterfaceStyle {
        appearanceData[selectedAppearanceIndex].appearanceId
    }
}
