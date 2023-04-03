//
//  ReminderListRowView.swift
//  Remedmind
//
//  Created by Davide Aliti on 07/02/23.
//

import SwiftUI

struct ReminderListRowView: View {
    // MARK: - Properties
    @EnvironmentObject var themeSettings: ThemeSettings
    
    @ObservedObject var reminder: Reminder
    
    // MARK: - Body
    var body: some View {
        VStack() {
            HStack {
                MedicineImageView()
                MedicineNameBrandView(medicineName: reminder.medicineName ?? "No medicine name", medicineBrand: reminder.medicineBrand ?? "No medicine brand")
                Spacer()
                AdministrationFrequencyView(administrationQuantity: reminder.administrationQuantity, administrationType: reminder.administrationType ?? "pill", numberOfAdministrations: reminder.numberOfAdministrations, administrationFrequency: reminder.administrationFrequency ?? "daily")
            }
            WeekAdministrationView()
                .environmentObject(self.themeSettings)
                .padding(.vertical, 3)
            PackageRemainderView(currentPackageQuantity: reminder.currentPackageQuantity, administrationType: reminder.administrationType ?? "pill")
        }
        .padding()
    }
}

// MARK: - Preview
struct ReminderListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListRowView(reminder: Reminder(context: PersistenceController.preview.container.viewContext))
            .environmentObject(ThemeSettings())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
