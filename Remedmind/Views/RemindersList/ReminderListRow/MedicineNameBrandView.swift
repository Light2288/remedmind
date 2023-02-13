//
//  MedicineNameBrandView.swift
//  Remedmind
//
//  Created by Davide Aliti on 08/02/23.
//

import SwiftUI

struct MedicineNameBrandView: View {
    // MARK: - Properties
    var medicineName: String?
    var medicineBrand: String?
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(medicineName ?? "Unknown medicine name")
                .font(.headline)
            Text(medicineBrand ?? "Unknown medicine brand")
                .font(.footnote)
        }
    }
}

// MARK: - Preview
struct MedicineNameBrandView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineNameBrandView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
