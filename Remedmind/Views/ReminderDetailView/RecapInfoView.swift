//
//  RecapInfoView.swift
//  Remedmind
//
//  Created by Davide Aliti on 15/02/23.
//

import SwiftUI

struct RecapInfoView: View {
    // MARK: - Properties
    @ObservedObject var reminder: Reminder
    @State private var isExpanded: Bool = false
    
    // MARK: - Body
    var body: some View {
        DisclosureGroup("Informazioni generali", isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Marca: \(reminder.medicineBrand ?? "No medicine brand")")
                .padding(.top, 8)
                Text("Descrizione: \(reminder.medicineDescription ?? "No medicine description")")
                Text("Note: \(reminder.notes ?? "No medicine notes")")
                Text("Tipologia medicina: \(reminder.administrationType ?? "pill")")
                Text("Quantità per ogni assunzione: \(reminder.administrationQuantity.formatted(.number))")
                Text("Dosi giornaliere: \(reminder.numberOfAdministrations)")
                Text("Frequenza di assunzione: \(reminder.administrationFrequency ?? "daily")")
                Text("Data di inizio: \(DateFormatter.dayMonthYearFormatter.string(from: reminder.startDate ?? Date.now))")
                if reminder.endDate != Date.distantFuture {
                    Text("Data di fine: \(reminder.endDate ?? Date.distantFuture)")
                }
            }
            .font(.subheadline)
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .leading
            )
        }
        .padding(.horizontal)
    }
}

// MARK: - Preview
struct RecapInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RecapInfoView(reminder: Reminder(context: PersistenceController.preview.container.viewContext))
    }
}
