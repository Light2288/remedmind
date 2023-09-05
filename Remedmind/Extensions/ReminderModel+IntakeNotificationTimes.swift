//
//  ReminderModel+IntakeNotificationTimes.swift
//  Remedmind
//
//  Created by Davide Aliti on 26/08/23.
//

import Foundation

extension ReminderModel {
    func dayIntervalInSeconds(for numberOfAdministrations: Int) -> Int {
        let secondsInADay = 86400
        return secondsInADay/numberOfAdministrations
    }
    
    func secondsToHoursMinutes(_ seconds: Int) -> (Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60)
    }
    
    func dayIntervalInHoursMinutes(for numberOfAdministrations: Int) -> (hours: Int, minutes: Int) {
        return secondsToHoursMinutes(dayIntervalInSeconds(for: numberOfAdministrations))
    }
    
    mutating func createAdministrationNotificationTimes(_ intakeNotificationType: IntakeNotificationType, startingAt intakeNotificationDefaultTimeShadow: Double) {
        guard self.administrationNotificationTimes.isEmpty else { return }

        let dayIntervalInSeconds = dayIntervalInSeconds(for: Int(self.medicine.numberOfAdministrations))
        let dayIntervalHoursMinutes = dayIntervalInHoursMinutes(for: Int( self.medicine.numberOfAdministrations))
        
        
        var startDate = Date.now
        var dateComponents = DateComponents()
        switch intakeNotificationType {
        case .automatic:
            dateComponents.hour = dayIntervalHoursMinutes.hours
            dateComponents.minute = dayIntervalHoursMinutes.minutes
            startDate = Calendar.customLocalizedCalendar.date(from: dateComponents) ?? Date.now
        case .custom:
            startDate = Date(rawValue: intakeNotificationDefaultTimeShadow)
        }
        self.administrationNotificationTimes.append(startDate)
        guard self.medicine.numberOfAdministrations > 1 else { return }
        for _ in 2...self.medicine.numberOfAdministrations {
            startDate = startDate.addingTimeInterval(TimeInterval(dayIntervalInSeconds))
            self.administrationNotificationTimes.append(startDate)
        }
        
    }
}
