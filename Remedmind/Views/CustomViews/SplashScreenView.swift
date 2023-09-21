//
//  SplashScreenView.swift
//  Remedmind
//
//  Created by Davide Aliti on 18/09/23.
//

import SwiftUI

struct SplashScreenView: View {
    // MARK: - Properties
    @State private var imageScale = 0.7
    @State private var imageOpacity = 0.0
    @State private var imageDegree = 0.0
    @State private var textOpacity = 0.0
    @EnvironmentObject var themeSettings: ThemeSettings
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemBackground))
                .ignoresSafeArea()
            VStack {
                Image("splashscreen-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .scaleEffect(imageScale)
                    .opacity(imageOpacity)
                    .rotationEffect(.degrees(imageDegree), anchor: .top)
                    .onAppear {
                        let appearAnimation = Animation.easeInOut(duration: 0.3)

                        withAnimation(appearAnimation) {
                            imageScale = 1.0
                            imageOpacity = 1.0
                        }
                        
                        let initialRingBellAnimation = Animation.easeIn(duration: 0.1).delay(0.5)
                        
                        withAnimation(initialRingBellAnimation) {
                            imageDegree = 25.0
                        }
                        
                        let ringBellAnimation = Animation.interpolatingSpring(mass: 0.2, stiffness: 170, damping: 1.5, initialVelocity: 0).delay(0.6)
                        
                        withAnimation(ringBellAnimation) {
                            imageDegree = 0.0
                        }
                    }
                Text("Remedmind")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(themeSettings.selectedThemePrimaryColor)
                    .opacity(textOpacity)
                    .onAppear {
                        let appearAnimation = Animation.easeInOut(duration: 0.5).delay(0.5)
                        
                        withAnimation(appearAnimation) {
                            textOpacity = 1.0
                        }
                    }
            }
            
        }
    }
}

// MARK: - Preview
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
