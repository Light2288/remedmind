//
//  ReminderDetailView.swift
//  Remedmind
//
//  Created by Davide Aliti on 13/02/23.
//

import SwiftUI

struct ReminderDetailView: View {
    // MARK: - Properties
    var reminder: Reminder
    var localizedCalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: Locale.preferredLanguages[0])
        return calendar
    }
    @State var selectedDay = Date.now
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                TitleInfoView(title: reminder.medicineName)
                DailyIntakeView(numberOfAdministrations: Int(reminder.numberOfAdministrations), selectedDay: $selectedDay)
                CalendarIntakeView(calendar: localizedCalendar, selectedDay: $selectedDay)
                RecapInfoView(reminder: reminder)
                Spacer()
            }
        .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview
struct ReminderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDetailView(reminder: Reminder(context: PersistenceController.preview.container.viewContext))
            .environmentObject(ThemeSettings())
    }
}
