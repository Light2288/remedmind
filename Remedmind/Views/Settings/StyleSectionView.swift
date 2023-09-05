//
//  StyleSectionView.swift
//  Remedmind
//
//  Created by Davide Aliti on 17/08/23.
//

import SwiftUI

struct StyleSectionView: View {
    // MARK: - Properties
    
    // MARK: - Body
    var body: some View {
        Section {
            AppearancePickerView()
            ThemePickerView()
            IconPickerView()
        } header: {
            Text("settingsView.style.title")
        }
        .padding(.vertical, 3)
    }
}

// MARK: - Preview
struct StyleSectionView_Previews: PreviewProvider {
    static var previews: some View {
        StyleSectionView()
    }
}
