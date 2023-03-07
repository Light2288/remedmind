//
//  SizeCalculatorViewModifier.swift
//  Remedmind
//
//  Created by Davide Aliti on 07/03/23.
//

import SwiftUI

struct SizeCalculator: ViewModifier {
    
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            size = proxy.size
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                size = proxy.size
                            }
                        }
                }
            )
    }
}
