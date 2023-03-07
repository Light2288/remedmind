//
//  DailyIntakeDetailView.swift
//  Remedmind
//
//  Created by Davide Aliti on 02/03/23.
//

import SwiftUI

struct DailyIntakeDetailView: View {
    // MARK: - Properties
    let height: CGFloat
    let numberOfAdministrations: Int
    
    @Binding var dailyIntake: Int
    @Binding var selectedDay: Date
    
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }

    
    // MARK: - Body
    var body: some View {
        ZStack {
            Circle()
                .fill(themeSettings.selectedThemePrimaryColor)
                .frame(width: height, height: height, alignment: .center)
                .zIndex(0)
            Circle()
                .fill(Color(.systemBackground))
                .frame(width: height-20, height: height-20, alignment: .center)
                .zIndex(1)
            VStack {
                Text("\(dailyIntake.description)/\(numberOfAdministrations)")
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 3, trailing: 0))
                    .font(.title)
                Text(dateFormatter.string(from: selectedDay))
                    .font(.footnote)
                Spacer()
            }
            .zIndex(2)
        }
        .frame(width: height, height: height)
    }
}

// MARK: - Preview
struct DailyIntakeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DailyIntakeDetailView(height: 120, numberOfAdministrations: 5, dailyIntake: .constant(0), selectedDay: .constant(Date.now))
            .environmentObject(ThemeSettings())
    }
}
