//
//  AddReminderStepTwoView.swift
//  Remedmind
//
//  Created by Davide Aliti on 19/07/23.
//

import SwiftUI

struct AddReminderStepTwoView: View {
    // MARK: - Properties
    @Binding var reminder: ReminderModel
    @EnvironmentObject var themeSettings: ThemeSettings
    @Binding var showModal: Bool
    
    // MARK: - Body
    var body: some View {
            VStack {
                List {
                    AdministrationSectionView(reminder: $reminder, hasTitle: false)
                }
                if reminder.medicine.administrationType.canRunLow {
                    NavigationLink(destination: AddReminderStepThreeView(reminder: $reminder, showModal: $showModal)) {
                        Text("label.next")
                            .font(.title3)
                            .padding(.all, 8)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(themeSettings.selectedThemePrimaryColor)
                    .padding()
                }
                else {
                    SaveReminderButtonView(reminder: $reminder, showModal: $showModal)
                }
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
struct AddReminderStepTwoView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderStepTwoView(reminder: .constant(ReminderModel()), showModal: .constant(true))
    }
}
