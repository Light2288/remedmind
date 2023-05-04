//
//  OuterCirclePieChart.swift
//  Remedmind
//
//  Created by Davide Aliti on 17/04/23.
//

import SwiftUI

struct OuterCirclePieChart: View {
    // MARK: - Properties
    let fraction: Double
    let fillColor: Color
    let strokeBorder: Color
    let strokeWidth: Double
    
    // MARK: - Body
    var body: some View {
        GeometryReader { proxy in
            let radius = min(proxy.size.width, proxy.size.height) / 2.0
            let center = CGPoint(x: proxy.size.width / 2.0, y: proxy.size.height / 2.0)
            let startAngle = 360.0
            let endAngle = startAngle - fraction * 360.0
            Path { pieChart in
                pieChart.move(to: center)
                pieChart.addArc(center: center, radius: radius, startAngle: .degrees(startAngle), endAngle: .degrees(endAngle), clockwise: true)
                pieChart.closeSubpath()
            }
            .fill(fillColor, strokeBorder: strokeBorder, lineWidth: strokeWidth)
            .rotationEffect(.degrees(-90 + 360 * fraction))
        }
    }
}

// MARK: - Preview
struct OuterCirclePieChart_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            OuterCirclePieChart(fraction: 0.66, fillColor: .green, strokeBorder: Color.clear, strokeWidth: 0)
            OuterCirclePieChart(fraction: 0.75, fillColor: .green, strokeBorder: Color.clear, strokeWidth: 0)
        }
    }
}
