//
//  ReminderDetailView.swift
//  Remedmind
//
//  Created by Davide Aliti on 13/02/23.
//

import SwiftUI

struct ReminderDetailView: View {
    // MARK: - Properties
    @State var reminder: Reminder
    var localizedCalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: Locale.preferredLanguages[0])
        return calendar
    }
    
    @State var selectedDay = Date.now
    @State private var isEditViewPresented: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var themeSettings: ThemeSettings
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                TitleInfoView(title: reminder.medicineName)
                DailyIntakeView(numberOfAdministrations: Int(reminder.numberOfAdministrations), selectedDay: $selectedDay)
                CalendarIntakeView(calendar: localizedCalendar, selectedDay: $selectedDay, startDate: reminder.startDate, endDate: reminder.endDate)
                RecapInfoView(reminder: reminder)
                NotificationsInfoView(reminder: reminder)
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        isEditViewPresented.toggle()
                    } label: {
                        Label("Edit", systemImage: "square.and.pencil")
                    }
                    Button(role: .destructive) {
                        
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $isEditViewPresented) {
            AddEditReminderView(showModal: $isEditViewPresented, reminderToEdit: $reminder)
                .environment(\.managedObjectContext, viewContext)
                .environmentObject(self.themeSettings)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
struct ReminderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReminderDetailView(reminder: Reminder(context: PersistenceController.preview.container.viewContext))
                .environmentObject(ThemeSettings())
        }
    }
}
