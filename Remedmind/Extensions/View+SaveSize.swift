//
//  View+SaveSize.swift
//  Remedmind
//
//  Created by Davide Aliti on 07/03/23.
//

import SwiftUI

extension View {
    func saveSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}
