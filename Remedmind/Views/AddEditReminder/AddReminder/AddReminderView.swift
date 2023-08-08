//
//  AddReminderView.swift
//  Remedmind
//
//  Created by Davide Aliti on 19/07/23.
//

import SwiftUI

struct AddReminderView: View {
    // MARK: - Properties
    @State var reminder: ReminderModel = ReminderModel()
    @Binding var showModal: Bool
    
    // MARK: - Body
    var body: some View {
        AddReminderStepOneView(reminder: $reminder, showModal: $showModal)
    }
}

// MARK: - Preview
struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView(showModal: .constant(true))
    }
}
