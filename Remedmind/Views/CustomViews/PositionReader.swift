//
//  PositionReader.swift
//  Remedmind
//
//  Created by Davide Aliti on 10/04/23.
//

import SwiftUI

struct PositionReader: View {
    // MARK: - Properties
    let tag: Int
    let value: Anchor<CGPoint>.Source
    
    // MARK: - Body
    var body: some View {
        Color.clear.anchorPreference(key: Positions.self, value: value) { (anchor) in
            [PositionData(id: self.tag, center: anchor)]
        }
    }
}

// MARK: - Preview
struct PositionReader_Previews: PreviewProvider {
    static var previews: some View {
        PositionReader(tag: 0, value: .bottomTrailing)
    }
}
