//
//  RecapInfoView.swift
//  Remedmind
//
//  Created by Davide Aliti on 15/02/23.
//

import SwiftUI

struct RecapInfoView: View {
    // MARK: - Properties
    var reminder: Reminder
    @State private var isExpanded: Bool = false
    
    // MARK: - Body
    var body: some View {
        DisclosureGroup("Informazioni generali", isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Marca: \(reminder.medicineBrand ?? "Unknown medicine brand")")
                    .font(.headline)
                    .padding(.top, 8)
                Text("Descrizione: \(reminder.medicineDescription ?? "No description")")
                    .font(.subheadline)
                Text("Note: \(reminder.notes ?? "No notes")")
                    .font(.subheadline)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .leading
            )
        }
        .padding()
    }
}

// MARK: - Preview
struct RecapInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RecapInfoView(reminder: Reminder(context: PersistenceController.preview.container.viewContext))
    }
}
