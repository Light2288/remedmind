//
//  AdministrationFrequencyPickerView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/03/23.
//

import SwiftUI

struct AdministrationFrequencyPickerView: View {
    // MARK: - Properties
    @Binding var reminder: ReminderModel
    
    // MARK: - Body
    var body: some View {
        Picker("Frequenza somministrazione", selection: $reminder.medicine.administrationFrequency) {
            ForEach(AdministrationFrequency.allCases, id: \.self) { frequency in
                Text("\(frequency.rawValue)").tag(frequency)
            }
        }
        .onChange(of: reminder.medicine.administrationFrequency) { (value) in
            if reminder.medicine.administrationFrequency == .daily {
                reminder.medicine.administrationDays.enumerated().forEach { index, _ in reminder.medicine.administrationDays[index] = true }
            } else {
                reminder.medicine.administrationDays.enumerated().forEach { index, _ in reminder.medicine.administrationDays[index] = false }
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

// MARK: - Preview
struct AdministrationFrequencyPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrationFrequencyPickerView(reminder: .constant(ReminderModel()))
    }
}
