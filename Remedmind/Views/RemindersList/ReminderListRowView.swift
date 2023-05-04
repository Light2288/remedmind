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
    @Binding var selectedReminder: Reminder?
    @Binding var selectedDay: Date
    @Binding var showAddIntakeOverlayView: Bool
    
    // MARK: - Body
    var body: some View {
        VStack() {
            HStack {
                MedicineImageView()
                MedicineNameBrandView(medicineName: reminder.medicineName ?? "No medicine name", medicineBrand: reminder.medicineBrand ?? "No medicine brand")
                Spacer()
                AdministrationFrequencyView(administrationQuantity: reminder.administrationQuantity, administrationType: reminder.administrationType ?? "pill", numberOfAdministrations: reminder.numberOfAdministrations, administrationFrequency: reminder.administrationFrequency ?? "daily")
            }
            WeekAdministrationView(reminder: reminder, selectedDay: $selectedDay, selectedReminder: $selectedReminder, showAddIntakeOverlayView: $showAddIntakeOverlayView)
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
        ReminderListRowView(reminder: Reminder(context: PersistenceController.preview.container.viewContext), selectedReminder: .constant(Reminder(context: PersistenceController.preview.container.viewContext)), selectedDay: .constant(Date.now), showAddIntakeOverlayView: .constant(false))
            .environmentObject(ThemeSettings())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
