//
//  AddReminderView.swift
//  Remedmind
//
//  Created by Davide Aliti on 05/12/22.
//

import SwiftUI

struct EditReminderView: View {
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var themeSettings: ThemeSettings
    @State var reminder = ReminderModel()
    @State var showConfirmationModal: Bool = false
    @FocusState private var focusedField: Field?
    @Binding var showModal: Bool
    @Binding var reminderToEdit: Reminder
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                List {
                    GeneralInfoSectionView(reminder: $reminder, focusedField: _focusedField, hasTitle: true)

                    AdministrationSectionView(reminder: $reminder, focusedField: _focusedField, hasTitle: true)
                    
                    if reminder.medicine.administrationType.canRunLow {
                        RunningLowSectionView(reminder: $reminder, focusedField: _focusedField, hasTitle: true)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color(.systemBackground))
                SaveReminderButtonView(reminder: $reminder, showConfirmationModal: $showConfirmationModal, showModal: $showModal, focusedField: _focusedField, reminderToEdit: $reminderToEdit)

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


        }
        .tint(themeSettings.selectedThemePrimaryColor)
        .onAppear {
            reminder.update(from: reminderToEdit)
        }
    }
}

// MARK: - Preview
struct AddEditReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditReminderView(showModal: .constant(true), reminderToEdit: .constant(Reminder()))
                .environmentObject(ThemeSettings())
        }
    }
}
