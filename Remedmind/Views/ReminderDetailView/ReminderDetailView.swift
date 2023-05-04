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
    @State var showDeleteReminderAlert: Bool = false
    @State var selectedDay = Date.now
    @State private var isEditViewPresented: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var themeSettings: ThemeSettings
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                TitleInfoView(title: reminder.medicineName)
                if reminder.getDailyIntake(for: selectedDay)?.todayTotalIntakes == 0 {
                    Text("No intakes for today")
                } else {
                    DailyIntakeView(selectedDay: $selectedDay, reminder: $reminder)
                }
                CalendarIntakeView(startDate: reminder.startDate, endDate: reminder.endDate, selectedDay: $selectedDay, reminder: reminder)
                RecapInfoView(reminder: reminder)
                NotificationsInfoView(reminder: reminder)
                Spacer()
            }
        }
        .onAppear {
            selectedDay = reminder.isIntakeDay(for: Date.now) ? Date.now : (reminder.lastDayWithIntakes ?? Date.now)
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
                        showDeleteReminderAlert = true
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
        .alert("Eliminazione promemoria", isPresented: $showDeleteReminderAlert, actions: {
            Button("Elimina promemoria", role: .destructive) {
                presentationMode.wrappedValue.dismiss()
                DispatchQueue.main.async {
                    viewContext.delete(reminder)
                    do {
                        try viewContext.save()
                    }catch{
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
            }
            Button("Annulla", role: .cancel) { }
        }, message: {
            Text("Sei sicuro di voler eliminare questo promemoria?")
        })
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
