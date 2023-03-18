//
//  AddReminderView.swift
//  Remedmind
//
//  Created by Davide Aliti on 05/12/22.
//

import SwiftUI

struct AddEditReminderView: View {
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var themeSettings: ThemeSettings
    @State var reminder = ReminderModel()
    @Binding var showModal: Bool
    
    var localizedVeryShortWeekdaysSymbols: [String] = Array(Calendar.current.veryShortWeekdaySymbols[Calendar.current.firstWeekday - 1 ..< Calendar.current.veryShortWeekdaySymbols.count] + Calendar.current.veryShortWeekdaySymbols[0 ..< Calendar.current.firstWeekday - 1])
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Nome", text: $reminder.medicine.name)
                        TextField("Marca", text: $reminder.medicine.brand)
                        TextField("Descrizione", text: $reminder.medicine.description)
                        TextField("Note", text: $reminder.notes)
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
                                        Toggle(
                                            isOn: $reminder.medicine.administrationDays[index]) {
                                                Text(localizedVeryShortWeekdaysSymbols[index].prefix(1))
                                                    .font(.footnote)
                                            }
                                            .toggleStyle(.button)
                                            .tint(themeSettings.selectedThemePrimaryColor)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        Stepper("Dosi giornaliere: \(reminder.medicine.numberOfAdministrations)", value: $reminder.medicine.numberOfAdministrations)
                            .onChange(of: reminder.medicine.numberOfAdministrations) { newValue in
                                if reminder.administrationNotificationTimes.count < newValue {
                                    let newNotificationTimes = Array(repeating: Date.now, count: newValue - reminder.administrationNotificationTimes.count)
                                    reminder.administrationNotificationTimes.append(contentsOf: newNotificationTimes)
                                } else {
                                    reminder.administrationNotificationTimes.removeLast(reminder.administrationNotificationTimes.count - newValue)
                                }
                            }
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
                        if reminder.activeAdministrationNotification {
                            ForEach(Array(reminder.administrationNotificationTimes.enumerated()), id: \.offset) { index, _ in
                                DatePicker("Orario della notifica per la dose \(index+1)", selection: $reminder.administrationNotificationTimes[index], displayedComponents: .hourAndMinute)
                            }
                        }
                    } header: {
                        Text("Frequenza somministrazione e dosaggio")
                    }
                    
                    if reminder.medicine.administrationType == .pill || reminder.medicine.administrationType == .sachet {
                        Section {
                            Toggle(isOn: $reminder.activeRunningLowNotification) {
                                Text("Ricevi una notifica quando la confezione sta per esaurirsi")
                            }
                            if reminder.activeRunningLowNotification {
                                DatePicker("Orario della notifica", selection: $reminder.runningLowNotificationTime, displayedComponents: .hourAndMinute)
                                HStack {
                                    Text("\(reminder.medicine.administrationType == .pill ? "Pillole" : "Bustine") in una confezione:")
                                    Spacer()
                                    TextField("", value: $reminder.medicine.packageQuantity, formatter: NumberFormatter())
                                        .keyboardType(.decimalPad)
                                        .fixedSize()
                                        .textFieldStyle(.roundedBorder)
                                }
                                VStack(alignment: .leading) {
                                    Text("Se hai una confezione già iniziata, indica qui quante \(reminder.medicine.administrationType == .pill ? "pillole" : "bustine") sono rimaste")
                                        .font(.footnote)
                                    HStack {
                                        Text("\(reminder.medicine.administrationType == .pill ? "Pillole" : "Bustine") rimaste nella confezione attuale:")
                                        Spacer()
                                        TextField("", value: $reminder.medicine.currentPackageQuantity, formatter: NumberFormatter())
                                            .keyboardType(.decimalPad)
                                            .fixedSize()
                                            .textFieldStyle(.roundedBorder)
                                    }
                                }
                            }
                            
                        } header: {
                            Text("Esaurimento Confezione")
                        }
                    }
                }
                Button {
                    let newReminder = Reminder(context: viewContext)
                    newReminder.id = UUID()
                    newReminder.medicineName = reminder.medicine.name
                    newReminder.medicineBrand = reminder.medicine.brand
                    newReminder.medicineDescription = reminder.medicine.description
                    newReminder.image = reminder.image
                    newReminder.notes = reminder.notes
                    newReminder.startDate = reminder.startDate
                    newReminder.administrationFrequency = reminder.medicine.administrationFrequency.rawValue
                    newReminder.administrationDays = reminder.medicine.administrationDays as NSObject
                    newReminder.numberOfAdministrations = Int32(reminder.medicine.numberOfAdministrations)
                    newReminder.administrationQuantity = reminder.medicine.administrationQuantity
                    newReminder.administrationType = reminder.medicine.administrationType.rawValue
                    newReminder.activeAdministrationNotification = reminder.activeAdministrationNotification
                    newReminder.administrationNotificationTimes = reminder.administrationNotificationTimes as NSObject
                    newReminder.activeRunningLowNotification =  reminder.activeRunningLowNotification
                    newReminder.runningLowNotificationTime = reminder.runningLowNotificationTime
                    newReminder.packageQuantity = Int32(reminder.medicine.packageQuantity)
                    newReminder.currentPackageQuantity = Float(reminder.medicine.currentPackageQuantity)
                    newReminder.endDate = reminder.endDate
                    do {
                        try viewContext.save()
                        showModal = false
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                } label: {
                    Text("Salva")
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
                        Label("Close", systemImage: "xmark.circle.fill")
                    }
                }
            }
            .navigationTitle("Nuovo Promemoria Medicina")
            .navigationBarTitleDisplayMode(.inline)
        }
        .tint(themeSettings.selectedThemePrimaryColor)
    }
}

// MARK: - Preview
struct AddEditReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddEditReminderView(showModal: .constant(true))
                .environmentObject(ThemeSettings())
        }
    }
}
