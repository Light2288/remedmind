//
//  OuterCircleEmpty.swift
//  Remedmind
//
//  Created by Davide Aliti on 17/04/23.
//

import SwiftUI

struct OuterCircleEmpty: View {
    // MARK: - Properties
    let fillColor: Color
    let strokeBorder: Color
    let strokeWidth: Double
    
    // MARK: - Body
    var body: some View {
        Circle()
            .fillWithBorder(fillColor, strokeBorder: strokeBorder, lineWidth: strokeWidth)
    }
}

// MARK: - Preview
struct OuterCircleEmpty_Previews: PreviewProvider {
    static var previews: some View {
        OuterCircleEmpty(fillColor: .clear, strokeBorder: Color(.systemGray), strokeWidth: 1)
    }
}
