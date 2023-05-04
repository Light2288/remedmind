//
//  Shape+FillStroke.swift
//  Remedmind
//
//  Created by Davide Aliti on 14/04/23.
//

import Foundation
import SwiftUI

extension Shape {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke = .clear, lineWidth: Double = 1) -> some View {
        self
            .stroke(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle))
    }
}
