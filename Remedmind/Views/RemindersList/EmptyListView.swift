//
//  EmptyListView.swift
//  Remedmind
//
//  Created by Davide Aliti on 14/09/23.
//

import SwiftUI

struct EmptyListView: View {
    // MARK: - Properties
    @EnvironmentObject var themeSettings: ThemeSettings
    @State private var opacity: Double = 0
    @State private var offset: CGSize = CGSize(width: 0, height: -50)
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image("list-icon")
                .resizable()
                .scaledToFit()
                .foregroundColor(themeSettings.selectedThemePrimaryColor)
                .frame(minWidth: 200, idealWidth: 250, maxWidth: 300, minHeight: 200, idealHeight: 250, maxHeight: 300, alignment: .center)
            Text("listView.emptyListText")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(themeSettings.selectedThemePrimaryColor)
                .multilineTextAlignment(.center)
        }
        .opacity(opacity)
        .offset(offset)
        .onAppear {
            withAnimation(.easeOut(duration: 1)) {
                opacity = 1
                offset = .zero
            }
        }
        .padding()
    }
}

// MARK: - Preview
struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
