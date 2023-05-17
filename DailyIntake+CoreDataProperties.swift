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

extension DailyIntake : Identifiable {
    static func getTotalIntakes(from reminder: Reminder, for date: Date = Date.now) -> Int32 {
        guard let administrationFrequency = reminder.administrationFrequencyEnumValue else
        { return 0 }
        
        switch administrationFrequency {
        case .daily:
            return reminder.numberOfAdministrations
        
        case .everyOtherDay:
            return Calendar.customLocalizedCalendar.numberOfDaysBetween(reminder.startDate ?? Date.now, and: date) % 2 == 0 ? reminder.numberOfAdministrations : 0
        
        case .weekly:
            return reminder.unlocalizedAdministrationDays[Calendar.customLocalizedCalendar.dateComponents([.weekday], from: date).weekday! - 1] ? reminder.numberOfAdministrations : 0
        }
    }
    
}
