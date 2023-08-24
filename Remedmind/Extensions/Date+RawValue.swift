//
//  Date+RawValue.swift
//  Remedmind
//
//  Created by Davide Aliti on 23/08/23.
//

import Foundation

extension Date: RawRepresentable {
    public var rawValue: Double {
        self.timeIntervalSinceReferenceDate
    }
    
    public init(rawValue: Double) {
        self = Date(timeIntervalSinceReferenceDate: rawValue)
    }
}
