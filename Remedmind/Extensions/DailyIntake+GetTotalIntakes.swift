//
//  DailyIntake+GetTotalIntakes.swift
//  Remedmind
//
//  Created by Davide Aliti on 23/05/23.
//

import Foundation
import CoreData

extension DailyIntake : Identifiable {
    static func getTotalIntakes(from reminder: Reminder, for date: Date = Date.now) -> Int32 {
        guard let administrationFrequency = reminder.administrationFrequencyEnumValue else
        { return 0 }
        
        guard Calendar.customLocalizedCalendar.compare(date, to: reminder.endDate ?? Date.distantFuture, toGranularity: .day) == .orderedAscending else { print("\(reminder.medicineName) enter else");return 0 }
        
        switch administrationFrequency {
        case .daily:
            return reminder.numberOfAdministrations
        
        case .everyOtherDay:
            return Calendar.customLocalizedCalendar.numberOfDaysBetween(reminder.startDate ?? Date.now, and: date) % 2 == 0 ? reminder.numberOfAdministrations : 0
        
        case .weekly:
            return reminder.unlocalizedAdministrationDays[Calendar.customLocalizedCalendar.dateComponents([.weekday], from: date).weekday! - 1] ? reminder.numberOfAdministrations : 0
        }
    }
    
    static func createDailyIntake(from reminder: Reminder, for date: Date, context: NSManagedObjectContext) -> DailyIntake {
        let dailyIntake = DailyIntake(context: context)
        dailyIntake.id = UUID()
        dailyIntake.date = date
        dailyIntake.takenDailyIntakes = Int32.zero
        dailyIntake.todayTotalIntakes = DailyIntake.getTotalIntakes(from: reminder, for: date)
        return dailyIntake
    }
    
}
