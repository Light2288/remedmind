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
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }
    
    // MARK: - Body
    var body: some View {
        DisclosureGroup("Informazioni generali", isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Marca: \(reminder.medicineBrand)")
                .padding(.top, 8)
                Text("Descrizione: \(reminder.medicineDescription)")
                Text("Note: \(reminder.notes)")
                Text("Tipologia medicina: \(reminder.administrationType)")
                Text("Quantità per ogni assunzione: \(reminder.administrationQuantity.formatted(.number))")
                Text("Dosi giornaliere: \(reminder.numberOfAdministrations)")
                Text("Frequenza di assunzione: \(reminder.administrationFrequency)")
                Text("Data di inizio: \(dateFormatter.string(from: reminder.startDate))")
                if reminder.endDate != Date.distantFuture {
                    Text("Data di fine: \(reminder.endDate)")
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
