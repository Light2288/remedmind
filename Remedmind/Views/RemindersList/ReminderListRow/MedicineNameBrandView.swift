//
//  MedicineNameBrandView.swift
//  Remedmind
//
//  Created by Davide Aliti on 08/02/23.
//

import SwiftUI

struct MedicineNameBrandView: View {
    // MARK: - Properties
    var medicineName: String
    var medicineBrand: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(medicineName)
                .font(.headline)
            Text(medicineBrand)
                .font(.footnote)
        }
    }
}

// MARK: - Preview
struct MedicineNameBrandView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineNameBrandView(medicineName: "Aspirina", medicineBrand: "Bayern")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
