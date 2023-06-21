//
//  String+CapitalizeFirstLetter.swift
//  Remedmind
//
//  Created by Davide Aliti on 07/06/23.
//

import Foundation

extension String {
    var capitalizedFirstLetter: String {
        return self.prefix(1).capitalized + dropFirst()
    }
}
