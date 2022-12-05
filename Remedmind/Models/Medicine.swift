//
//  Medicine.swift
//  Remedmind
//
//  Created by Davide Aliti on 05/12/22.
//

import Foundation

struct Medicine: Identifiable {
    let id = UUID()
    
    var name: String
    var brand: String
    var description: String
    var image: String?
    var notes: String?
    
    var administrationFrequency: AdministrationFrequency
    var administrationQuantity: Float
    
    var packageQuantity: Int
}
