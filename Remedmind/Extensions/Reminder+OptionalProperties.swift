//
//  Reminder+OptionalProperties.swift
//  Remedmind
//
//  Created by Davide Aliti on 30/05/23.
//

import Foundation

extension Reminder {
    var medicineNameString: String {
        guard let medicineName = self.medicineName, !medicineName.isEmpty else { return String(localized: "label.medicine.noName") }
        return medicineName
    }
    
    var medicineBrandString: String {
        guard let medicineBrand = self.medicineBrand, !medicineBrand.isEmpty else { return String(localized: "label.medicine.noBrand") }
        return medicineBrand
    }
    
    var medicineDescriptionString: String {
        guard let medicineDescription = self.medicineDescription, !medicineDescription.isEmpty else { return String(localized: "label.medicine.noDescription") }
        return medicineDescription
    }
    
    var notesString: String {
        guard let notes = self.notes, !notes.isEmpty else { return String(localized: "label.medicine.noNotes") }
        return notes
    }
    
    var administrationTypeString: String {
        guard let administrationTypeString = self.administrationType, !administrationTypeString.isEmpty, let administrationType = AdministrationType(rawValue: administrationTypeString) else { return String(localized: "label.medicine.noAdministrationType") }
        return self.administrationQuantity <= 1.0 ? administrationType.administrationTypeDescription : administrationType.administrationTypeDescriptionPlural
    }
    
    var administrationFrequencyString: String {
        guard let administrationFrequencyString = self.administrationFrequency, !administrationFrequencyString.isEmpty, let administrationFrequency = AdministrationFrequency(rawValue: administrationFrequencyString) else { return String(localized: "label.medicine.noAdministrationFrequency") }
        return administrationFrequency.administrationFrequencyDescription
    }
    
    var additionalAdministrationFrequencyString: String {
        guard let administrationFrequencyString = self.administrationFrequency, !administrationFrequencyString.isEmpty, AdministrationFrequency(rawValue: administrationFrequencyString) == .weekly else { return "" }
        return ", " + ListFormatter.localizedString(byJoining: localizedLongAdministrationDays )
    }
    
    var startDateString: String {
        guard let startDate = self.startDate else { return DateFormatter.dayMonthYearFormatter.string(from: Date.now) }
        return DateFormatter.dayMonthYearFormatter.string(from: startDate)
    }
    
    var endDateString: String {
        guard let startDate = self.startDate else { return DateFormatter.dayMonthYearFormatter.string(from: Date.now) }
        return DateFormatter.dayMonthYearFormatter.string(from: startDate)
    }
    
    var administrationNotificationsTimesString: String {
        guard let administrationNotificationTimes = administrationNotificationTimes, !administrationNotificationTimes.isEmpty else { return "" }
        return ListFormatter.localizedString(byJoining: administrationNotificationTimes.map { DateFormatter.hourMinuteFormatter.string(from:$0) } )
    }
    
    var runningLowNotificationsTimeString: String {
        guard let runningLowNotificationTime = runningLowNotificationTime else { return "" }
        return DateFormatter.hourMinuteFormatter.string(from:runningLowNotificationTime)
    }
}
