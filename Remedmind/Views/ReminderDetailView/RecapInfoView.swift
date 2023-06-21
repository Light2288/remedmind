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
        DisclosureGroup("detailView.generalInfo.title", isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 8) {
                Text("detailView.generalInfo.label.medicineBrand \(reminder.medicineBrandString)")
                .padding(.top, 8)
                Text("detailView.generalInfo.label.medicineDescription \(reminder.medicineDescriptionString)")
                Text("detailView.generalInfo.label.notes \(reminder.notesString)")
                Text("detailView.generalInfo.label.administrationType \(reminder.administrationTypeString)")
                Text("detailView.generalInfo.label.administrationQuantity \(reminder.administrationQuantity.formatted(.number))")
                Text("detailView.generalInfo.label.numberOfAdministrations \(reminder.numberOfAdministrations)")
                Text(String(localized: "detailView.generalInfo.label.administrationFrequency \(reminder.administrationFrequencyString.capitalizedFirstLetter)") + String(localized: "detailView.generalInfo.label.additionalAdministrationFrequency \(reminder.additionalAdministrationFrequencyString)"))
                Text("detailView.generalInfo.label.startDate \(reminder.startDateString)")
                if reminder.endDate != Date.distantFuture {
                    Text("detailView.generalInfo.label.endDate \(reminder.endDateString)")
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
