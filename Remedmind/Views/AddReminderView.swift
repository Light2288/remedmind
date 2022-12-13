//
//  AddReminderView.swift
//  Remedmind
//
//  Created by Davide Aliti on 05/12/22.
//

import SwiftUI

struct AddReminderView: View {
    // MARK: - Properties
    @State var reminder: Reminder
    
    // MARK: - Body
    var body: some View {
        VStack {
            List {
                Section {
                    TextField("Nome", text: $reminder.medicine.name)
                    TextField("Marca", text: $reminder.medicine.brand)
                    TextField("Descrizione", text: $reminder.medicine.description)
                    TextField("Note", text: $reminder.medicine.notes)
                } header: {
                    Text("Informazioni generali")
                }

                Section {
                    Picker("Frequenza somministrazione", selection: $reminder.medicine.administrationFrequency) {
                        ForEach(AdministrationFrequency.allCases, id: \.self) { frequency in
                            Text(frequency.rawValue).tag(frequency)
                        }
                    }
                    .onChange(of: reminder.medicine.administrationFrequency) { (value) in
                        if reminder.medicine.administrationFrequency == .daily {
                            reminder.medicine.administrationDays.enumerated().forEach { index, _ in reminder.medicine.administrationDays[index] = true }
                        } else {
                            reminder.medicine.administrationDays.enumerated().forEach { index, _ in reminder.medicine.administrationDays[index] = false }
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    if reminder.medicine.administrationFrequency == .weekly {
                        VStack {
                            Text("Seleziona i giorni di assunzione".uppercased())
                                .font(.footnote)
                            HStack {
                                Spacer()
                                ForEach(Array(reminder.medicine.administrationDays.enumerated()), id: \.offset) { index, _ in
//                                    Toggle(Calendar.current.weekdaySymbols[index].prefix(1), isOn: $reminder.medicine.administrationDays[index])
//                                        .toggleStyle(.button)
                                    Toggle(
                                        isOn: $reminder.medicine.administrationDays[index]) {
                                            Text(Calendar.current.weekdaySymbols[index].prefix(1))
                                                .font(.footnote)
                                        }
                                        .toggleStyle(.button)
                                }
                                Spacer()
                            }
                        }
                    }
                    Stepper("Dosi giornaliere: \(reminder.medicine.numberOfAdministrations)", value: $reminder.medicine.numberOfAdministrations)
                    Stepper(value: $reminder.medicine.administrationQuantity, in: 0 ... .infinity, step: 0.5) {
                        HStack(spacing: 0) {
                            Text("Dose: \(reminder.medicine.administrationQuantity.description)")
                            Picker("", selection: $reminder.medicine.administrationType) {
                                ForEach(AdministrationType.allCases, id: \.self)
                                        { administrationType in
                                            Text(administrationType.rawValue).tag(administrationType)
                                }
                            }
                            .labelsHidden()
                        }
                        
                    }
                    Toggle(isOn: $reminder.activeAdministrationNotification) {
                        Text("Ricevi una notifica per ricordarti di assumere la medicina")
                    }
                } header: {
                    Text("Frequenza somministrazione e dosaggio")
                }
                
                if reminder.medicine.administrationType == .pill || reminder.medicine.administrationType == .sachet {
                    Section {
                        Toggle(isOn: $reminder.activeRunningLowNotification) {
                            Text("Ricevi una notifica per quando la confezione sta per esaurirsi")
                        }
                        Stepper("\(reminder.medicine.administrationType == .pill ? "Pillole" : "Bustine") in una confezione: \(reminder.medicine.packageQuantity)", value: $reminder.medicine.packageQuantity)
                        VStack(alignment: .leading) {
                            Text("Se hai una confezione già iniziata, indica qui quante \(reminder.medicine.administrationType == .pill ? "pillole" : "bustine") sono rimaste")
                                .font(.footnote)
                            Stepper("\(reminder.medicine.administrationType == .pill ? "Pillole" : "Bustine") rimaste nella confezione attuale: \(reminder.medicine.currentPackageQuantity)", value: $reminder.medicine.currentPackageQuantity)
                        }
                        
                    } header: {
                        Text("Esaurimento Confezione")
                    }
                }
            }
            Button {
                print(reminder)
            } label: {
                Text("Salva")
                    .font(.title3)
                    .padding(.all, 8)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()

        }
        .navigationTitle("Nuovo Promemoria Medicina")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddReminderView(reminder: Reminder(medicine: Medicine(name: "", brand: "", description: "", image: "", notes: "", administrationFrequency: .daily, administrationQuantity: 0, numberOfAdministrations: 3, packageQuantity: 30, currentPackageQuantity: 10), activeAdministrationNotification: false, activeRunningLowNotification: false))
        }
    }
}
