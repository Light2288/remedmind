//
//  Medicine.swift
//  Remedmind
//
//  Created by Davide Aliti on 05/12/22.
//

import Foundation

struct MedicineModel {
    var name: String = ""
    var brand: String = ""
    var description: String = ""
    
    var administrationFrequency: AdministrationFrequency = .daily
    var administrationQuantity: Float = 1.0
    var administrationType: AdministrationType = .pill
    var numberOfAdministrations: Int32 = 1
    
    var administrationDays: Array<Bool> = Array.init(repeating: true, count: 7)
    
    var packageQuantity: Int32 = 0
    var currentPackageQuantity: Float = 0.0
}

extension MedicineModel {
    var unlocalizedAdministrationDays: [Bool] { Array(self.administrationDays[Calendar.customLocalizedCalendar.veryShortWeekdaySymbols.count - Calendar.customLocalizedCalendar.firstWeekday + 1 ..< Calendar.customLocalizedCalendar.veryShortWeekdaySymbols.count] + self.administrationDays[0 ..< Calendar.customLocalizedCalendar.veryShortWeekdaySymbols.count - Calendar.customLocalizedCalendar.firstWeekday + 1])
    }
    
    func administrationDaysFromUnlocalized(unlocalizedAdministrationDays: [Bool]) -> [Bool] {
        return Array(unlocalizedAdministrationDays[Calendar.customLocalizedCalendar.firstWeekday - 1 ..< Calendar.customLocalizedCalendar.veryShortWeekdaySymbols.count] + unlocalizedAdministrationDays[0 ..< Calendar.customLocalizedCalendar.firstWeekday - 1])
    }
    
    var administrationTypeString: String {
        return AdministrationType(rawValue: administrationType.rawValue)?.administrationTypeDescription ?? String(localized: "administrationType.other")
    }
    
    mutating func update(from reminder: Reminder) {
        self.name = reminder.medicineName ?? ""
        self.brand = reminder.medicineBrand ?? ""
        self.description = reminder.medicineDescription ?? ""
        self.administrationFrequency = AdministrationFrequency(rawValue: reminder.administrationFrequency ?? "daily") ?? .daily
        self.administrationDays = administrationDaysFromUnlocalized(unlocalizedAdministrationDays: reminder.administrationDays)
        self.numberOfAdministrations = reminder.numberOfAdministrations
        self.administrationQuantity = reminder.administrationQuantity
        self.administrationType = AdministrationType(rawValue: reminder.administrationType ?? "pill") ?? .pill
        self.packageQuantity = reminder.packageQuantity
        self.currentPackageQuantity = reminder.currentPackageQuantity
    }
}
