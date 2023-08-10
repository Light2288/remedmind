//
//  AddReminderView.swift
//  Remedmind
//
//  Created by Davide Aliti on 19/07/23.
//

import SwiftUI

struct AddReminderStepOneView: View {
    // MARK: - Properties
    @Binding var reminder: ReminderModel
    @EnvironmentObject var themeSettings: ThemeSettings
    @Binding var showModal: Bool
    @State private var navigateToStepTwo: Bool = false
    @State private var showConfirmationModal: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Image("step-1-icon-default")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                List {
                    GeneralInfoSectionView(reminder: $reminder, hasTitle: false)
                }
                .scrollContentBackground(.hidden)
                .background(Color(.systemBackground))
                Button {
                    guard reminder.medicine.name != "" else {
                        showConfirmationModal = true
                        return
                    }
                    navigateToStepTwo = true
                } label: {
                    Text("label.next")
                        .font(.title3)
                        .padding(.all, 8)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(themeSettings.selectedThemePrimaryColor)
                .padding()
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
            .navigationDestination(isPresented: $navigateToStepTwo) {
                AddReminderStepTwoView(reminder: $reminder, showModal: $showModal)
            }
            .alert("alert.noMedicineName.title", isPresented: $showConfirmationModal) {
                Button("alert.noMedicineName.confirm") {
                    DispatchQueue.main.async {
                        self.navigateToStepTwo = true
                    }
                }
                Button("button.cancel.label", role: .cancel) { }
            } message: {
                Text("alert.noMedicineName.message")
            }
        }
        .tint(themeSettings.selectedThemePrimaryColor)
    }
}

// MARK: - Preview
struct AddReminderStepOneView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderStepOneView(reminder: .constant(ReminderModel()), showModal: .constant(true))
    }
}
