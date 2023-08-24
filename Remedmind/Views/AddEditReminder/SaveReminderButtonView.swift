//
//  SaveReminderButtonView.swift
//  Remedmind
//
//  Created by Davide Aliti on 08/08/23.
//

import SwiftUI

struct SaveReminderButtonView: View {
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var themeSettings: ThemeSettings
    @Binding var reminder: ReminderModel
    var showConfirmationModal: Binding<Bool>? = nil
    @Binding var showModal: Bool
    @FocusState var focusedField: Field?
    var reminderToEdit: Binding<Reminder>? = nil
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    
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
            if reminderToEdit == nil && (newReminder.activeAdministrationNotification || newReminder.activeRunningLowNotification) {
                addNotifications(for: newReminder)
            }
            showModal = false
            hapticFeedback.notificationOccurred(.success)
        } catch {
            let nsError = error as NSError
            fatalError("error.coredata.saving \(nsError) \(nsError.userInfo)")
        }
    }
    
    // MARK: - Body
    var body: some View {
        Button {
            focusedField = nil
            guard showConfirmationModal == nil || reminder.medicine.name != "" else {
                showConfirmationModal?.wrappedValue = true
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
        .alert("alert.noMedicineName.title", isPresented: showConfirmationModal?.projectedValue ?? .constant(false)) {
            Button("alert.noMedicineName.confirm") {
                updateReminderAndSave(from: reminder)
            }
            Button("button.cancel.label", role: .cancel) { }
        } message: {
            Text("alert.noMedicineName.message")
        }
    }
}

// MARK: - Preview
struct SaveReminderButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveReminderButtonView(reminder: .constant(ReminderModel()), showConfirmationModal: .constant(false), showModal: .constant(true))
    }
}
