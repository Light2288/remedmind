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
                    fatalError("error.coredata.saving \(nsError) \(nsError.userInfo)")
                }
            }
        })
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                TitleInfoView(title: reminder.medicineNameString)
                if reminder.getDailyIntake(for: selectedDay)?.todayTotalIntakes == 0 {
                    Text("label.noIntakes")
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
                            Label("label.edit", systemImage: "square.and.pencil")
                        }
                        Button(role: .destructive) {
                            showStopTrackingAlert = true
                        } label: {
                            Label("label.stopTracking", systemImage: "clock.badge.xmark")
                        }
                    } else {
                        Button {
                            resumeTracking(for: reminder)
                        } label: {
                            Label("label.resumeTracking", systemImage: "clock.badge.checkmark")
                        }
                    }
                    Button(role: .destructive) {
                        showDeleteReminderAlert = true
                    } label: {
                        Label("label.delete", systemImage: "trash")
                    }
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $isEditViewPresented) {
            EditReminderView(showModal: $isEditViewPresented, reminderToEdit: $reminder)
                .environment(\.managedObjectContext, viewContext)
                .environmentObject(self.themeSettings)
        }
        .alert("alert.stopTracking.title", isPresented: $showStopTrackingAlert, actions: {
            Button("alert.stopTracking.stopButton", role: .destructive) {
                stopTracking(for: reminder)
            }
            Button("button.cancel.label", role: .cancel) { }
        }, message: {
            Text("alert.stopTracking.message \(reminder.medicineName ?? "")")
        })
        .alert("alert.deleteReminder.title", isPresented: $showDeleteReminderAlert, actions: {
            Button("alert.deleteReminder.deleteButton", role: .destructive) {
                delete(reminder)
            }
            Button("button.cancel.label", role: .cancel) { }
        }, message: {
            Text("alert.deleteReminder.message")
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
