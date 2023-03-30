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

    
    // MARK: - Body
    var body: some View {
        Section {
            TextField("Nome", text: $reminder.medicine.name)
            TextField("Marca", text: $reminder.medicine.brand)
            TextField("Descrizione", text: $reminder.medicine.description)
            TextField("Note", text: $reminder.notes)
        } header: {
            Text("Informazioni generali")
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
