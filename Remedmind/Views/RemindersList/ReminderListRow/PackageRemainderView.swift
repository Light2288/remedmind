//
//  PackageRemainderView.swift
//  Remedmind
//
//  Created by Davide Aliti on 09/02/23.
//

import SwiftUI

struct PackageRemainderView: View {
    // MARK: - Properties
    var currentPackageQuantity: Float
    var administrationType: String
    
    // MARK: - Body
    var body: some View {
        Text("\(currentPackageQuantity.formatted(.number)) \(administrationType) rimanenti nella confezione")
            .font(.footnote)
    }
}

// MARK: - Preview
struct PackageRemainderView_Previews: PreviewProvider {
    static var previews: some View {
        PackageRemainderView(currentPackageQuantity: 22.5, administrationType: "pill")
    }
}
