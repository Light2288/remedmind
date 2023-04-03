//
//  Reminder+CoreDataProperties.swift
//  Remedmind
//
//  Created by Davide Aliti on 22/03/23.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var activeAdministrationNotification: Bool
    @NSManaged public var activeRunningLowNotification: Bool
    @NSManaged public var administrationDays: [Bool]
    @NSManaged public var administrationFrequency: String?
    @NSManaged public var administrationNotificationTimes: [Date]?
    @NSManaged public var administrationQuantity: Float
    @NSManaged public var administrationType: String?
    @NSManaged public var currentPackageQuantity: Float
    @NSManaged public var endDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var image: String?
    @NSManaged public var medicineBrand: String?
    @NSManaged public var medicineDescription: String?
    @NSManaged public var medicineName: String?
    @NSManaged public var notes: String?
    @NSManaged public var numberOfAdministrations: Int32
    @NSManaged public var packageQuantity: Int32
    @NSManaged public var runningLowNotificationTime: Date?
    @NSManaged public var startDate: Date?

}

extension Reminder : Identifiable {

}
