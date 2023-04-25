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
    func getTodayTotalIntakes(from reminder: Reminder) -> Int32 {
        guard let administrationFrequency = AdministrationFrequency(rawValue: reminder.administrationFrequency ?? "") else
        { return 0 }
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: Locale.preferredLanguages[0])

        
        switch administrationFrequency {
        case .daily:
            return reminder.numberOfAdministrations
        
        case .everyOtherDay:
            let dailyIntakesArray: [DailyIntake] = Array(reminder.dailyIntakes ?? Set<DailyIntake>())
            guard dailyIntakesArray.count > 0 else { return reminder.numberOfAdministrations }
            let sortedDailyIntakes = dailyIntakesArray.sorted(by: { $0.date!.compare($1.date!) == .orderedAscending })
            guard let lastDailyIntake = sortedDailyIntakes.last else { return reminder.numberOfAdministrations }
            return lastDailyIntake.todayTotalIntakes == 0 ? reminder.numberOfAdministrations : 0
        
        case .weekly:
            let unlocalizedAdministrationDays = Array(reminder.administrationDays[calendar.veryShortWeekdaySymbols.count - calendar.firstWeekday + 1 ..< calendar.veryShortWeekdaySymbols.count] + reminder.administrationDays[0 ..< calendar.veryShortWeekdaySymbols.count - calendar.firstWeekday + 1])
            print("Administration days: \(reminder.administrationDays)")
            print("Unlocalized administration days: \(unlocalizedAdministrationDays)")
            print("Weekday: \(calendar.dateComponents([.weekday], from: self.date!).weekday!)")
            print("First day of week: \(calendar.firstWeekday)")
            print(unlocalizedAdministrationDays[calendar.dateComponents([.weekday], from: self.date!).weekday! - 1])
            
            return unlocalizedAdministrationDays[calendar.dateComponents([.weekday], from: self.date!).weekday! - 1] ? reminder.numberOfAdministrations : 0
        }
    }
    
    func getTodayTotalIntakes(from reminder: Reminder, dailyIntakesArraySource dailyIntakesArray: [DailyIntake]) -> Int32 {
        guard let administrationFrequency = AdministrationFrequency(rawValue: reminder.administrationFrequency ?? "") else
        { return 0 }
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: Locale.preferredLanguages[0])

        
        switch administrationFrequency {
        case .daily:
            return reminder.numberOfAdministrations
        case .everyOtherDay:
            print("Before guard")
            guard dailyIntakesArray.count > 0 else { return reminder.numberOfAdministrations }
            print("Pass guard")
            let sortedDailyIntakes = dailyIntakesArray.sorted(by: { $0.date!.compare($1.date!) == .orderedAscending })
            guard let lastDailyIntake = sortedDailyIntakes.last else { return reminder.numberOfAdministrations }
            print(sortedDailyIntakes.count)
            print(lastDailyIntake.date)
            print(lastDailyIntake.todayTotalIntakes)
            return lastDailyIntake.todayTotalIntakes == 0 ? reminder.numberOfAdministrations : 0
        case .weekly:
            
            let unlocalizedAdministrationDays = Array(reminder.administrationDays[calendar.veryShortWeekdaySymbols.count - calendar.firstWeekday + 1 ..< calendar.veryShortWeekdaySymbols.count] + reminder.administrationDays[0 ..< calendar.veryShortWeekdaySymbols.count - calendar.firstWeekday + 1])
            print("Administration days: \(reminder.administrationDays)")
            print("Unlocalized administration days: \(unlocalizedAdministrationDays)")
            print("Weekday: \(calendar.dateComponents([.weekday], from: self.date!).weekday!)")
            print("First day of week: \(calendar.firstWeekday)")
            print(unlocalizedAdministrationDays[calendar.dateComponents([.weekday], from: self.date!).weekday! - 1])
            
            return unlocalizedAdministrationDays[calendar.dateComponents([.weekday], from: self.date!).weekday! - 1] ? reminder.numberOfAdministrations : 0
        }
    }
}
