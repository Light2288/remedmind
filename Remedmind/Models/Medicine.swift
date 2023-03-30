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
    mutating func update(from reminder: Reminder) {
        self.name = reminder.medicineName
        self.brand = reminder.medicineBrand
        self.description = reminder.medicineDescription
        self.administrationFrequency = AdministrationFrequency(rawValue: reminder.administrationFrequency) ?? .daily
        self.administrationDays = reminder.administrationDays
        self.numberOfAdministrations = reminder.numberOfAdministrations
        self.administrationQuantity = reminder.administrationQuantity
        self.administrationType = AdministrationType(rawValue: reminder.administrationType) ?? .pill
        self.packageQuantity = reminder.packageQuantity
        self.currentPackageQuantity = reminder.currentPackageQuantity
    }
}
