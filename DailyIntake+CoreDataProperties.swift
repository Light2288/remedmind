//
//  DailyIntake+CoreDataProperties.swift
//  Remedmind
//
//  Created by Davide Aliti on 12/04/23.
//
//

import Foundation
import CoreData


extension DailyIntake {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyIntake> {
        return NSFetchRequest<DailyIntake>(entityName: "DailyIntake")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var takenDailyIntakes: Int32
    @NSManaged public var todayTotalIntakes: Int32
    @NSManaged public var reminder: Reminder?

}
