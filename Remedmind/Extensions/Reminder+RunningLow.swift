//
//  Reminder+RunningLow.swift
//  Remedmind
//
//  Created by Davide Aliti on 13/07/23.
//

import Foundation
import CoreData

extension Reminder {
    
    func getRunningLowNotificationDate() -> Date {

        guard self.currentPackageQuantity > Float(self.numberOfAdministrations) * self.administrationQuantity else { return Date.now }

        let endDate = Calendar.customLocalizedCalendar.date(byAdding: .day, value: 14, to: Date.now)!
        let futureIntakes = self.getFutureIntakeDates(to: endDate)

        let futurePackageQuantities = futureIntakes.enumerated().map { self.currentPackageQuantity - (Float(self.numberOfAdministrations) * self.administrationQuantity * Float($0.offset)) }
        
        guard let lastDayIndex = (futurePackageQuantities.lastIndex { $0 >= Float(self.numberOfAdministrations) * self.administrationQuantity }) else { return Date.distantFuture }
        
        return futureIntakes[lastDayIndex]
        
    }
}
