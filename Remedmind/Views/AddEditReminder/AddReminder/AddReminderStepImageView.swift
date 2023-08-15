//
//  AddReminderStepImageView.swift
//  Remedmind
//
//  Created by Davide Aliti on 15/08/23.
//

import SwiftUI

struct AddReminderStepImageView: View {
    // MARK: - Properties
    var imageName: String
    @State private var scale = 0.3
    
    // MARK: - Body
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .padding(.top, 16)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                    scale = 1.0
                }
            }
    }
}

// MARK: - Preview
struct AddReminderStepImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderStepImageView(imageName: "step-1-icon-default")
    }
}
