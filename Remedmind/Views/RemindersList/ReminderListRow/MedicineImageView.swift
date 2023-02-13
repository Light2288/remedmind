//
//  MedicineImageRowView.swift
//  Remedmind
//
//  Created by Davide Aliti on 08/02/23.
//

import SwiftUI

struct MedicineImageView: View {
    // MARK: - Properties
    var imageSize: CGFloat = 30
    
    // MARK: - Body
    var body: some View {
        Image(systemName: "pill.fill")
            .resizable()
            .padding(8)
            .frame(width: imageSize, height: imageSize, alignment: .center)
            .background {
                Color(.systemGray3)
            }
            .cornerRadius(imageSize/2)
            .shadow(radius: 1)
    }
}

// MARK: - Preview
struct MedicineImageView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineImageView()
            .previewLayout(.sizeThatFits)
    }
}
