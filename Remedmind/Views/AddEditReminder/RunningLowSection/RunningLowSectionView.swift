//
//  RunningLowSectionView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/03/23.
//

import SwiftUI

struct RunningLowSectionView: View {
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @Binding var reminder: ReminderModel
    @FocusState var focusedField: Field?
    var hasTitle: Bool
    
    // MARK: - Body
    var body: some View {
        Section {
            RunningLowNotificationSectionView(reminder: $reminder)
            
            if reminder.activeRunningLowNotification {
                PackageQuantitiesSectionView(reminder: $reminder)
            }
            
        } header: {
            Text(hasTitle ? "addEditReminderView.packageExhaustion.title" : "")
        }
        .listRowBackground(colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6))
    }
}

// MARK: - Preview
struct RunningLowSectionView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            RunningLowSectionView(reminder: .constant(ReminderModel()), hasTitle: true)
        }
    }
}
