//
//  CalendarIntakeTitleView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/02/23.
//

import SwiftUI

struct CalendarIntakeHeaderView: View {
    // MARK: - Properties
    var calendar: Calendar
    var monthYearFormatter: DateFormatter {
        DateFormatter(dateFormat: "MMMM yyyy", calendar: calendar)
    }
    @Binding var monthStart: Date
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(monthYearFormatter.string(from: monthStart))
                .font(.headline)
                .padding()
            Spacer()
            Button {
                withAnimation {
                    guard let newDate = calendar.date(
                        byAdding: .month,
                        value: -1,
                        to: monthStart
                    ) else {
                        return
                    }
                    
                    monthStart = newDate.startOfMonth(using: calendar)
                }
            } label: {
                Label(
                    title: { Text("Previous") },
                    icon: { Image(systemName: "chevron.left") }
                )
                .labelStyle(IconOnlyLabelStyle())
                .padding(.horizontal)
                .frame(maxHeight: .infinity)
            }
            Button {
                withAnimation {
                    guard let newDate = calendar.date(
                        byAdding: .month,
                        value: 1,
                        to: monthStart
                    ) else {
                        return
                    }
                    monthStart = newDate.startOfMonth(using: calendar)
                }
            } label: {
                Label(
                    title: { Text("Next") },
                    icon: { Image(systemName: "chevron.right") }
                )
                .labelStyle(IconOnlyLabelStyle())
                .padding(.horizontal)
                .frame(maxHeight: .infinity)
            }
        }
        .padding(.bottom, 6)
    }
}

// MARK: - Preview
struct CalendarIntakeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarIntakeHeaderView(calendar: Calendar(identifier: .gregorian), monthStart: .constant(Date.now))
    }
}
