//
//  AddReminderButton.swift
//  Remedmind
//
//  Created by Davide Aliti on 06/04/23.
//

import SwiftUI

struct AddReminderButton: View {
    // MARK: - Properties
    @EnvironmentObject var themeSettings: ThemeSettings
    @Binding var isAddReminderViewPresented: Bool
    
    var plusSymbolSize: CGFloat = 32
    var innerCircleSize: CGFloat {
        plusSymbolSize + 16
    }
    var middleCircleSize: CGFloat {
        innerCircleSize + 20
    }
    var outerCircleSize: CGFloat {
        middleCircleSize + 20
    }
    
    @State var scale = 0.5
    @State var innerCircleOpacity = 0.0
    @State var outerCircleOpacity = 0.0
    @Binding var offset: CGSize
    @Binding var buttonOpacity: Double
    @Binding var plusSymbolColor: Color
    @Binding var plusSymbolScale: CGSize
    @Binding var plusSymbolOpacity: Double
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .fill(themeSettings.selectedThemeSecondaryColor)
                    .frame(width: innerCircleSize, height: innerCircleSize, alignment: .center)
                Circle()
                    .fill(themeSettings.selectedThemeSecondaryColor)
                    .opacity(innerCircleOpacity)
                    .scaleEffect(scale)
                    .frame(width: middleCircleSize, height: middleCircleSize, alignment: .center)
                Circle()
                    .fill(themeSettings.selectedThemeSecondaryColor)
                    .opacity(outerCircleOpacity)
                    .scaleEffect(scale)
                    .frame(width: outerCircleSize, height: outerCircleSize, alignment: .center)
            }
            .opacity(buttonOpacity)
            
            Button {
                isAddReminderViewPresented.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(plusSymbolColor)
                    .frame(width: plusSymbolSize, height: plusSymbolSize, alignment: .center)
                    .scaleEffect(plusSymbolScale)
                    .opacity(plusSymbolOpacity)
                    
            }
        }
        .offset(offset)
        .onAppear {
            let slideAnimation = Animation.spring(response: 0.55, dampingFraction: 0.45, blendDuration: 0)
            let pulsatingAnimation = Animation.easeOut(duration: 2.0).repeatForever(autoreverses: true).delay(3)
            
            withAnimation(slideAnimation) {
                offset = CGSize(width: 0, height: 0)
            }
            
            
            withAnimation(pulsatingAnimation) {
                scale = 1.0
                innerCircleOpacity = 0.2
                outerCircleOpacity = 0.15
            }
        }
    }
    
}

// MARK: - Preview
struct AddReminderButton_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderButton(isAddReminderViewPresented: .constant(false), offset: .constant(CGSize(width: 0, height: 0)), buttonOpacity: .constant(1.0), plusSymbolColor: .constant(Color(.systemBackground)), plusSymbolScale: .constant(CGSize(width: 1, height: 1)), plusSymbolOpacity: .constant(1.0))
            .environmentObject(ThemeSettings())
    }
}
