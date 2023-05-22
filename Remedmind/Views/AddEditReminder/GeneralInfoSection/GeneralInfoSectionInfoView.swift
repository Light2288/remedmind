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
            TextField("Nome", text: $reminder.medicine.name)
                .focused($focusedField, equals: .medicineName)
            TextField("Marca", text: $reminder.medicine.brand)
                .focused($focusedField, equals: .medicineBrand)
            TextField("Descrizione", text: $reminder.medicine.description)
                .focused($focusedField, equals: .medicineDescription)
            TextField("Note", text: $reminder.notes)
                .focused($focusedField, equals: .notes)
        } header: {
            Text("Informazioni generali")
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
