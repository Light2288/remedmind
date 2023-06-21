//
//  PackageQuantitiesSectionView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/03/23.
//

import SwiftUI

struct PackageQuantitiesSectionView: View {
    // MARK: - Properties
    @Binding var reminder: ReminderModel
    var currentPackageQuantityFormatter: Formatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("addEditReminderView.packageExhaustion.packageQuantity \(reminder.medicine.administrationTypeString.capitalizedFirstLetter)")
                Spacer()
                TextField("", value: $reminder.medicine.packageQuantity, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                    .fixedSize()
                    .textFieldStyle(.roundedBorder)
            }
            Text("addEditReminderView.packageExhaustion.currentPackageQuantity.label \(reminder.medicine.administrationTypeString) \(reminder.medicine.administrationTypeString)")
                .font(.footnote)
            HStack {
                Text("addEditReminderView.packageExhaustion.currentPackageQuantity \(reminder.medicine.administrationTypeString.capitalizedFirstLetter)")
                Spacer()
                TextField("", value: $reminder.medicine.currentPackageQuantity, formatter: currentPackageQuantityFormatter)
                    .keyboardType(.decimalPad)
                    .fixedSize()
                    .textFieldStyle(.roundedBorder)
            }
        }
    }
}

// MARK: - Preview
struct PackageQuantitiesSectionView_Previews: PreviewProvider {
    static var previews: some View {
        PackageQuantitiesSectionView(reminder: .constant(ReminderModel()))
    }
}
