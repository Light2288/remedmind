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
    @State private var showStopTrackingAlert: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var themeSettings: ThemeSettings
    
    func stopTracking(for reminder: Reminder) {
        reminder.endDate = Date.now
        reminder.deleteDailyIntake(for: Date.now, context: viewContext)
        presentationMode.wrappedValue.dismiss()
        LocalNotifications.shared.deleteAllNotificationRequests(for: reminder, { _ in })
    }
    
    func resumeTracking(for reminder: Reminder) {
        reminder.endDate = .distantFuture
        let todayDailyIntake = DailyIntake.createDailyIntake(from: reminder, for: Date.now, context: viewContext)
        reminder.addToDailyIntakes(Set([todayDailyIntake]))
        presentationMode.wrappedValue.dismiss()
    }
    
    func delete(_ reminder: Reminder) {
        presentationMode.wrappedValue.dismiss()
        LocalNotifications.shared.deleteAllNotificationRequests(for: reminder, { reminder in
            DispatchQueue.main.async{
                viewContext.delete(reminder)
                do {
                    try viewContext.save()
                }catch{
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        })
    }
    
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
                    if reminder.endDate == .distantFuture {
                        Button {
                            isEditViewPresented.toggle()
                        } label: {
                            Label("Edit", systemImage: "square.and.pencil")
                        }
                        Button(role: .destructive) {
                            showStopTrackingAlert = true
                        } label: {
                            Label("Stop tracking", systemImage: "clock.badge.xmark")
                        }
                    } else {
                        Button {
                            resumeTracking(for: reminder)
                        } label: {
                            Label("Resume tracking", systemImage: "clock.badge.checkmark")
                        }
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
        .alert("Stop tracking", isPresented: $showStopTrackingAlert, actions: {
            Button("Stop tracking", role: .destructive) {
                stopTracking(for: reminder)
            }
            Button("Annulla", role: .cancel) { }
        }, message: {
            Text("Sei sicuro di voler cancellare il tracciamento delle assunzioni di \(reminder.medicineName ?? "")? Il promemoria rimarrà presente nell'elenco ma non riceverai più notifiche di assunzione")
        })
        .alert("Eliminazione promemoria", isPresented: $showDeleteReminderAlert, actions: {
            Button("Elimina promemoria", role: .destructive) {
                delete(reminder)
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
