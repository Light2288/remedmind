//
//  Reminder+AddMissingDailyIntakes.swift
//  Remedmind
//
//  Created by Davide Aliti on 13/04/23.
//

import Foundation
import CoreData

extension Reminder {
    func createMissingDailyIntakes(context: NSManagedObjectContext) -> [DailyIntake] {
        var localizedCalendar : Calendar = Calendar(identifier: .gregorian)
        localizedCalendar.locale = Locale(identifier: Locale.preferredLanguages[0])

        let dailyIntakesArray: [DailyIntake] = Array(self.dailyIntakes ?? Set<DailyIntake>())
        var sortedDailyIntakes = dailyIntakesArray.sorted(by: { $0.date!.compare($1.date!) == .orderedAscending })
        guard let lastDailyIntake = sortedDailyIntakes.last else { return [] }
        
        print(lastDailyIntake.date)
        
        var startDate = localizedCalendar.date(byAdding: .day, value: 1, to: lastDailyIntake.date!)!
        
        while localizedCalendar.compare(startDate, to: Date.now, toGranularity: .day) != .orderedDescending {
//            print(startDate)
            let dailyIntake = DailyIntake(context: context)
            dailyIntake.id = UUID()
            dailyIntake.date = startDate
            dailyIntake.takenDailyIntakes = Int32.zero
            dailyIntake.todayTotalIntakes = dailyIntake.getTodayTotalIntakes(from: self, dailyIntakesArraySource: sortedDailyIntakes)
            sortedDailyIntakes.append(dailyIntake)
            startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        }
        
        return Array(sortedDailyIntakes.dropFirst())
    }
}
