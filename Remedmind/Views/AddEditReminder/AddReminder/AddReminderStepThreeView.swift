//
//  AddReminderStepThreeView.swift
//  Remedmind
//
//  Created by Davide Aliti on 07/08/23.
//

import SwiftUI

struct AddReminderStepThreeView: View {
    // MARK: - Properties
    @Binding var reminder: ReminderModel
    @EnvironmentObject var themeSettings: ThemeSettings
    @Binding var showModal: Bool
    
    // MARK: - Body
    var body: some View {
            VStack {
                AddReminderStepImageView(imageName: "step-1-icon-default")
                List {
                    RunningLowSectionView(reminder: $reminder, hasTitle: false)
                }
                .scrollContentBackground(.hidden)
                .background(Color(.systemBackground))
                SaveReminderButtonView(reminder: $reminder, showModal: $showModal)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showModal = false
                    } label: {
                        Label("button.close.label", systemImage: "xmark.circle")
                    }
                }
            }
            .navigationTitle("addEditReminderView.navigation.title")
            .navigationBarTitleDisplayMode(.inline)
        }
}

// MARK: - Preview
struct AddReminderStepThreeView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderStepThreeView(reminder: .constant(ReminderModel()), showModal: .constant(true))
    }
}
