//
//  View+GetPosition.swift
//  Remedmind
//
//  Created by Davide Aliti on 10/04/23.
//

import Foundation
import SwiftUI

extension View {
    func getPosition(proxy: GeometryProxy, tag: Int, preferences: [PositionData])->CGPoint {
        let p = preferences.filter({ (p) -> Bool in
            p.id == tag
        })[0]
        return proxy[p.center]
    }
}
