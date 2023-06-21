//
//  GeneralSectionInfoView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/03/23.
//

import SwiftUI

struct GeneralInfoSectionView: View {
    // MARK: - Properties
    @Binding var reminder: ReminderModel
    @FocusState var focusedField: Field?
    
    // MARK: - Body
    var body: some View {
        Section {
            TextField("addEditReminderView.generalInfo.label.medicineName", text: $reminder.medicine.name)
                .focused($focusedField, equals: .medicineName)
            TextField("addEditReminderView.generalInfo.label.medicineBrand", text: $reminder.medicine.brand)
                .focused($focusedField, equals: .medicineBrand)
            TextField("addEditReminderView.generalInfo.label.medicineDescription", text: $reminder.medicine.description)
                .focused($focusedField, equals: .medicineDescription)
            TextField("addEditReminderView.generalInfo.label.notes", text: $reminder.notes)
                .focused($focusedField, equals: .notes)
        } header: {
            Text("addEditReminderView.generalInfo.title")
        }
        .onSubmit {
            switch focusedField {
            case .medicineName:
                focusedField = .medicineBrand
            case .medicineBrand:
                focusedField = .medicineDescription
            case .medicineDescription:
                focusedField = .notes
            case .notes:
                focusedField = nil
            case .none:
                focusedField = nil
            }
        }
    }
}

// MARK: - Preview
struct GeneralInfoSectionInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            GeneralInfoSectionView(reminder: .constant(ReminderModel()))
        }
    }
}
