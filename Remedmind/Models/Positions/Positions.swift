//
//  Positions.swift
//  Remedmind
//
//  Created by Davide Aliti on 10/04/23.
//

import Foundation
import SwiftUI

struct Positions: PreferenceKey {
    static var defaultValue: [PositionData] = []
    static func reduce(value: inout [PositionData], nextValue: () -> [PositionData]) {
        value.append(contentsOf: nextValue())
    }
}
