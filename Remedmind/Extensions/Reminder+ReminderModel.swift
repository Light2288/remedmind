//
//  Reminder+Initializer.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/03/23.
//

import Foundation
import CoreData


extension Reminder {
    
    func update(from reminderModel: ReminderModel) {
        self.id = reminderModel.id
        self.medicineName = reminderModel.medicine.name
        self.medicineBrand = reminderModel.medicine.brand
        self.medicineDescription = reminderModel.medicine.description
        self.image = reminderModel.image
        self.notes = reminderModel.notes
        self.startDate = reminderModel.startDate
        self.administrationFrequency = reminderModel.medicine.administrationFrequency.rawValue
        self.administrationDays = reminderModel.medicine.unlocalizedAdministrationDays
        self.numberOfAdministrations = reminderModel.medicine.numberOfAdministrations
        self.administrationQuantity = reminderModel.medicine.administrationQuantity
        self.administrationType = reminderModel.medicine.administrationType.rawValue
        self.activeAdministrationNotification = reminderModel.activeAdministrationNotification
        self.administrationNotificationTimes = reminderModel.administrationNotificationTimes
        self.activeRunningLowNotification =  reminderModel.activeRunningLowNotification
        self.runningLowNotificationTime = reminderModel.runningLowNotificationTime
        self.packageQuantity = reminderModel.medicine.packageQuantity
        self.currentPackageQuantity = reminderModel.medicine.currentPackageQuantity
        self.endDate = reminderModel.endDate
    }
}
