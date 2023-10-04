//
//  Shape+Fill.swift
//  Remedmind
//
//  Created by Davide Aliti on 04/10/23.
//

import Foundation
import SwiftUI

extension Shape {
    func fillWithBorder<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke = .clear, lineWidth: Double = 1) -> some View {
        self
            .stroke(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle))
    }
}
