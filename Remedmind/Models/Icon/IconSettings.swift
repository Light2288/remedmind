//
//  IconSettings.swift
//  Remedmind
//
//  Created by Davide Aliti on 04/07/23.
//

import SwiftUI

class IconSettings: ObservableObject {
    @Published var selectedIconId: Int = UserDefaults.standard.integer(forKey: "Icon") {
        didSet {
            UserDefaults.standard.set(self.selectedIconId, forKey: "Icon")
        }
    }
    
    var selectedIconName: String? {
        guard self.selectedIconId != 0 else { return nil }
        return iconData.first { icon in
            icon.id == self.selectedIconId
        }?.iconName ?? "multicolor-light"
    }
}
