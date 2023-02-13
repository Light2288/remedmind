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
    
    var reminder: Reminder
    
    // MARK: - Body
    var body: some View {
        VStack() {
            HStack {
                MedicineImageView()
                MedicineNameBrandView(medicineName: reminder.medicineName, medicineBrand: reminder.medicineBrand)
                Spacer()
                AdministrationFrequencyView(administrationQuantity: reminder.administrationQuantity, administrationType: reminder.administrationType, numberOfAdministrations: reminder.numberOfAdministrations)
            }
            WeekAdministrationView()
                .environmentObject(self.themeSettings)
                .padding(.vertical, 3)
            PackageRemainderView(currentPackageQuantity: reminder.currentPackageQuantity, administrationType: reminder.administrationType)
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
