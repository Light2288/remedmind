//
//  AddReminderView.swift
//  Remedmind
//
//  Created by Davide Aliti on 05/12/22.
//

import SwiftUI

struct AddEditReminderView: View {
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var themeSettings: ThemeSettings
    @State var reminder = ReminderModel()
    @State private var showConfirmationModal: Bool = false
    @FocusState private var focusedField: Field?
    @Binding var showModal: Bool
    var reminderToEdit: Binding<Reminder>? = nil
    
    func addCurrentDayIntakes(for newReminder: Reminder) {
        let dailyIntake = DailyIntake(context: viewContext)
        dailyIntake.id = UUID()
        dailyIntake.date = Date.now
        dailyIntake.takenDailyIntakes = 0
        dailyIntake.todayTotalIntakes = DailyIntake.getTotalIntakes(from: newReminder)
        newReminder.addToDailyIntakes(dailyIntake)
    }
    
    func updateAndAddDailyIntakes(for newReminder: Reminder, from reminder: ReminderModel) {
        newReminder.update(from: reminder)
        guard let dailyIntakes = newReminder.dailyIntakes else { return }
        if dailyIntakes.isEmpty {
            addCurrentDayIntakes(for: newReminder)
        } else {
            newReminder.updateTotalDailyIntakes(for: Date.now, context: viewContext)
        }
    }
    
    func addNotifications(for newReminder: Reminder) {
        LocalNotifications.shared.deleteAndCreateNewNotificationRequests(for: newReminder)
    }
    
    func updateReminderAndSave(from reminderModel: ReminderModel) {
        let newReminder = reminderToEdit?.wrappedValue ?? Reminder(context: viewContext)
        updateAndAddDailyIntakes(for: newReminder, from: reminderModel)
        do {
            try viewContext.save()
            if reminderToEdit == nil && newReminder.activeAdministrationNotification {
                addNotifications(for: newReminder)
            }
            showModal = false
        } catch {
            let nsError = error as NSError
            fatalError("error.coredata.saving \(nsError) \(nsError.userInfo)")
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                List {
                    GeneralInfoSectionView(reminder: $reminder, focusedField: _focusedField)

                    AdministrationSectionView(reminder: $reminder, focusedField: _focusedField)
                    
                    if reminder.medicine.administrationType.canRunLow {
                        RunningLowSectionView(reminder: $reminder, focusedField: _focusedField)
                    }
                }
                Button {
                    focusedField = nil
                    guard reminder.medicine.name != "" else {
                        showConfirmationModal = true
                        return
                    }
                    updateReminderAndSave(from: reminder)                    
                } label: {
                    Text("button.save.label")
                        .font(.title3)
                        .padding(.all, 8)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(themeSettings.selectedThemePrimaryColor)
                .padding()

            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showModal = false
                    } label: {
                        Label("button.close.label", systemImage: "xmark.circle")
                    }
                }
            }
            .navigationTitle("addEditReminderView.navigation.title")
            .navigationBarTitleDisplayMode(.inline)
            .alert("alert.noMedicineName.title", isPresented: $showConfirmationModal) {
                Button("alert.noMedicineName.confirm") {
                    updateReminderAndSave(from: reminder)
                }
                Button("button.cancel.label", role: .cancel) { }
            } message: {
                Text("alert.noMedicineName.message")
            }

        }
        .tint(themeSettings.selectedThemePrimaryColor)
        .onAppear {
            guard let reminderToEdit = reminderToEdit else { return }
            reminder.update(from: reminderToEdit.wrappedValue)
        }
    }
}

// MARK: - Preview
struct AddEditReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddEditReminderView(showModal: .constant(true))
                .environmentObject(ThemeSettings())
        }
    }
}
