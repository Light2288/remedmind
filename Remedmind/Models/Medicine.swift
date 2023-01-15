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
    var numberOfAdministrations: Int = 0
    
    var administrationDays: Array<Bool> = Array.init(repeating: true, count: 7)
    
    var packageQuantity: Int = 0
    var currentPackageQuantity: Int = 0
}
