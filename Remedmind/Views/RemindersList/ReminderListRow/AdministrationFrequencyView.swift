//
//  AdministrationFrequencyView.swift
//  Remedmind
//
//  Created by Davide Aliti on 08/02/23.
//

import SwiftUI

struct AdministrationFrequencyView: View {
    // MARK: - Properties
    var reminder: Reminder
    
    var administrationFrequencyString: String {
        switch reminder.administrationFrequencyEnumValue {
        case .daily:
            return String(localized: "administrationFrequency.daily")
        case .everyOtherDay:
            return String(localized: "administrationFrequency.everyOtherDay")
        case .weekly:
            return String(localized: "listView.row.administrationFrequency.weekly \(reminder.additionalAdministrationFrequencyString)")
        case .none:
            return ""
        }
    }
    
    // MARK: - Body
    var body: some View {
        Text("listView.row.administrationFrequency \(reminder.administrationQuantity.formatted(.number)) \(reminder.administrationTypeString) \(reminder.numberOfAdministrations) \(reminder.administrationFrequencyString)")
            .font(.footnote)
            .multilineTextAlignment(.center)
    
    }
}

// MARK: - Preview
struct AdministrationFrequencyView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrationFrequencyView(reminder: Reminder(context: PersistenceController.preview.container.viewContext))
            .previewLayout(.sizeThatFits)
    }
}
