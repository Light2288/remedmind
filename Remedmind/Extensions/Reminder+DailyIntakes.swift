//
//  Reminder+AddMissingDailyIntakes.swift
//  Remedmind
//
//  Created by Davide Aliti on 13/04/23.
//

import Foundation
import CoreData

extension Reminder {
    var lastDailyIntake: DailyIntake? {
        let dailyIntakesArray: [DailyIntake] = Array(self.dailyIntakes ?? Set<DailyIntake>())
        let sortedDailyIntakes = dailyIntakesArray.sorted(by: { $0.date!.compare($1.date!) == .orderedAscending })
        return sortedDailyIntakes.last
    }
    
    var lastDayWithIntakes: Date? {
        self.dailyIntakes?.filter({ $0.todayTotalIntakes > 0}).sorted(by: { $0.date!.compare($1.date!) == .orderedAscending }).last?.date
    }
    
    func getDailyIntake(for day: Date) -> DailyIntake? {
        self.dailyIntakes?.filter({ dailyIntake in
            Calendar.customLocalizedCalendar.isDate(dailyIntake.date!, inSameDayAs: day)
        }).first
    }
    
    func getTakenIntakes(for day: Date = Date.now) -> Int32? {
        return self.dailyIntakes?.filter({ dailyIntake in
            Calendar.customLocalizedCalendar.isDate(dailyIntake.date!, inSameDayAs: day)
        }).first?.takenDailyIntakes
    }
    
    
    func getTotalIntakes(for day: Date = Date.now) -> Int32? {
        return self.dailyIntakes?.filter({ dailyIntake in
            Calendar.customLocalizedCalendar.isDate(dailyIntake.date!, inSameDayAs: day)
        }).first?.todayTotalIntakes
    }
    
    func getFractionOfTakenIntakes(for day: Date = Date.now) -> Double {
        guard let takenIntakes = self.getTakenIntakes(for: day), let totalIntakes = getTotalIntakes(for: day), totalIntakes != 0 else { return 0 }
        return Double(takenIntakes)/Double(totalIntakes)
    }
    
    func isIntakeDay(for day: Date) -> Bool {
        guard let totalIntakes = self.getTotalIntakes(for: day) else { return false }
        return totalIntakes > 0
    }
    
    func createMissingDailyIntakes(context: NSManagedObjectContext, until endDate: Date = Date.now) -> [DailyIntake] {
        guard let lastDailyIntake = lastDailyIntake else { return [] }
        
        var missingDailyIntakes = [lastDailyIntake]
        
        var startDate = Calendar.customLocalizedCalendar.date(byAdding: .day, value: 1, to: lastDailyIntake.date!)!
        
        while Calendar.customLocalizedCalendar.compare(startDate, to: endDate, toGranularity: .day) != .orderedDescending {
            let dailyIntake = DailyIntake.createDailyIntake(from: self, for: startDate, context: context)
            missingDailyIntakes.append(dailyIntake)
            startDate = Calendar.customLocalizedCalendar.date(byAdding: .day, value: 1, to: startDate)!
        }
        
        return Array(missingDailyIntakes.dropFirst())
    }
    
    func addMissingDailyIntakes(context: NSManagedObjectContext) {
        let missingDailyIntakes = self.createMissingDailyIntakes(context: context)
        let missingDailyIntakesSet: Set<DailyIntake> = Set(missingDailyIntakes)
        self.addToDailyIntakes(missingDailyIntakesSet)
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("error.coredata.saving \(nsError) \(nsError.userInfo)")
        }
    }
    
    func updateTakenDailyIntakes(for day: Date, intakesToAdd: Int32, context: NSManagedObjectContext) {
        guard let dailyIntake = self.getDailyIntake(for: day) else { return }
        dailyIntake.takenDailyIntakes += intakesToAdd
        self.addToDailyIntakes(dailyIntake)
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("error.coredata.saving \(nsError) \(nsError.userInfo)")
        }
    }
    
    func updateTotalDailyIntakes(for day: Date, context: NSManagedObjectContext) {
        guard let dailyIntake = self.getDailyIntake(for: day) else { return }
        dailyIntake.todayTotalIntakes = DailyIntake.getTotalIntakes(from: self, for: day)
        self.addToDailyIntakes(dailyIntake)
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("error.coredata.saving \(nsError) \(nsError.userInfo)")
        }
    }
    
    func updateCurrentPackageQuantity(by administrationQuantity: Float, context: NSManagedObjectContext) {
        switch self.currentPackageQuantity - administrationQuantity {
        case let difference where difference > Float(self.packageQuantity):
            self.currentPackageQuantity = difference - Float(self.packageQuantity)
        case let difference where difference <= 0:
            self.currentPackageQuantity = Float(self.packageQuantity) + difference
        case let difference where difference > 0:
            self.currentPackageQuantity -= administrationQuantity
        default:
            break
        }
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("error.coredata.saving \(nsError) \(nsError.userInfo)")
        }
    }
    
    func getFutureIntakeDates(from startDate: Date = Date.now, to endDate: Date) -> [Date] {
        var futureIntakeDates: [Date] = []
        var date = startDate
                
        while Calendar.customLocalizedCalendar.compare(date, to: endDate, toGranularity: .day) != .orderedDescending && Calendar.customLocalizedCalendar.compare(date, to: self.endDate ?? .distantFuture, toGranularity: .day) != .orderedDescending {
            
            if DailyIntake.getTotalIntakes(from: self, for: date) > 0 {
                futureIntakeDates.append(date)
            }
            date = Calendar.customLocalizedCalendar.date(byAdding: .day, value: 1, to: date)!
        }
        
        return futureIntakeDates
    }
    
    func deleteDailyIntake(for day: Date, context: NSManagedObjectContext) {
        guard let dailyIntake = self.getDailyIntake(for: day) else { return }
        context.delete(dailyIntake)
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("error.coredata.saving \(nsError) \(nsError.userInfo)")
        }
    }
}
