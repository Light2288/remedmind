//
//  AddReminderView.swift
//  Remedmind
//
//  Created by Davide Aliti on 05/12/22.
//

import SwiftUI

struct AddReminderView: View {
    // MARK: - Properties
    @State var medicine: Medicine
    
    // MARK: - Body
    var body: some View {
        VStack {
            Form {
                TextField("Nome", text: $medicine.name)
            }
            Spacer()
        }
        .navigationTitle("Nuovo Promemoria Medicina")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddReminderView(medicine: Medicine(name: "", brand: "", description: "", image: "", notes: "", administrationFrequency: .daily, administrationQuantity: 1.5, packageQuantity: 30))
        }
    }
}
