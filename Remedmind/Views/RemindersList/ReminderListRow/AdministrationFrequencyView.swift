//
//  AdministrationFrequencyView.swift
//  Remedmind
//
//  Created by Davide Aliti on 08/02/23.
//

import SwiftUI

struct AdministrationFrequencyView: View {
    // MARK: - Properties
    var administrationQuantity: Float?
    var administrationType: String?
    var numberOfAdministrations: Int32?
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .trailing) {
            Text("\(administrationQuantity?.formatted(.number) ?? "0") \(administrationType ?? "pills")")
            Text("\(numberOfAdministrations ?? 0) times a day")
        }
        .font(.footnote)
    }
}

// MARK: - Preview
struct AdministrationFrequencyView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrationFrequencyView(administrationQuantity: 2.55)
            .previewLayout(.sizeThatFits)
    }
}
