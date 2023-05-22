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
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                List {
                    GeneralInfoSectionView(reminder: $reminder, focusedField: _focusedField)

                    AdministrationSectionView(reminder: $reminder, focusedField: _focusedField)
                    
                    if reminder.medicine.administrationType == .pill || reminder.medicine.administrationType == .sachet {
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
                    Text("Salva")
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
                        Label("Close", systemImage: "xmark.circle")
                    }
                }
            }
            .navigationTitle("Nuovo Promemoria Medicina")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Attenzione", isPresented: $showConfirmationModal) {
                Button("Continua") {
                    updateReminderAndSave(from: reminder)
                }
                Button("Annulla", role: .cancel) { }
            } message: {
                Text("Stai salvando un promemoria senza il nome della medicina; sei sicuro di voler procedere?")
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
