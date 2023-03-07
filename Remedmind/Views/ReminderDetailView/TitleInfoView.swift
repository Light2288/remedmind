//
//  TitleInfoView.swift
//  Remedmind
//
//  Created by Davide Aliti on 01/03/23.
//

import SwiftUI

struct TitleInfoView: View {
    // MARK: - Properties
    var title: String?
    
    // MARK: - Body
    var body: some View {
        Text(title ?? "Unknown medicine name")
            .font(.largeTitle)
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .leading
            )
            .padding([.top, .leading])
    }
}

// MARK: - Preview
struct TitleInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TitleInfoView()
    }
}
