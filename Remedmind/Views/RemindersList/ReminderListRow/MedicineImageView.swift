//
//  MedicineImageRowView.swift
//  Remedmind
//
//  Created by Davide Aliti on 08/02/23.
//

import SwiftUI

struct MedicineImageView: View {
    // MARK: - Properties
    var imageSize: CGFloat = 34
    var administrationType: String?
    @EnvironmentObject var themeSettings: ThemeSettings
    
    // MARK: - Body
    var body: some View {
        Image("\(administrationType ?? "other")-icon-list")
            .resizable()
            .scaledToFit()
            .padding(5)
            .frame(width: imageSize, height: imageSize, alignment: .center)
            .background {
                Color(.systemGray5)
            }
            .foregroundColor(themeSettings.selectedThemePrimaryColor)
            .cornerRadius(imageSize/2)
            .shadow(radius: 1)
    }
}

// MARK: - Preview
struct MedicineImageView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineImageView(administrationType: "pill")
            .previewLayout(.sizeThatFits)
    }
}
