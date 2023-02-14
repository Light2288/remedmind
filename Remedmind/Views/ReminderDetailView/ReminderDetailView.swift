//
//  ReminderDetailView.swift
//  Remedmind
//
//  Created by Davide Aliti on 13/02/23.
//

import SwiftUI

struct ReminderDetailView: View {
    // MARK: - Properties
    var reminder: Reminder
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(reminder.medicineName ?? "Unknown medicine name")
                .font(.largeTitle)
            RecapInfoView(reminder: reminder)
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
struct ReminderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDetailView(reminder: Reminder(context: PersistenceController.preview.container.viewContext))
    }
}
