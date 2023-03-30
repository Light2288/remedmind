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
            Text("Se hai una confezione già iniziata, indica qui quante \(reminder.medicine.administrationType == .pill ? "pillole" : "bustine") sono rimaste")
                .font(.footnote)
            HStack {
                Text("\(reminder.medicine.administrationType == .pill ? "Pillole" : "Bustine") rimaste nella confezione attuale:")
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
