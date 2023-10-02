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
        VStack(alignment: .center, spacing: 15) {
            HStack {
                MedicineImageView(administrationType: reminder.administrationType)
                MedicineNameBrandView(medicineName: reminder.medicineNameString, medicineBrand: reminder.medicineBrandString)
            }
            AdministrationFrequencyView(reminder: reminder)
            WeekAdministrationView(reminder: reminder)
                .environmentObject(self.themeSettings)
            if reminder.activeRunningLowNotification {
                PackageRemainderView(currentPackageQuantity: reminder.currentPackageQuantity, administrationType: reminder.administrationTypeString)
            }
        }
        .padding(.vertical)
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
