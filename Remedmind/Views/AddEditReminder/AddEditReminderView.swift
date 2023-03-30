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
    @Binding var showModal: Bool
    var reminderToEdit: Binding<Reminder>? = nil
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                List {
                    GeneralInfoSectionView(reminder: $reminder)

                    AdministrationSectionView(reminder: $reminder)
                    
                    if reminder.medicine.administrationType == .pill || reminder.medicine.administrationType == .sachet {
                        RunningLowSectionView(reminder: $reminder)
                    }
                }
                Button {
//                    _ = Reminder(from: reminder, insertIntoManagedObjectContext: viewContext)
                    let newReminder = reminderToEdit?.wrappedValue ?? Reminder(context: viewContext)
                    newReminder.update(from: reminder)
                    do {
                        try viewContext.save()
                        showModal = false
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
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
