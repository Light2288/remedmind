import SwiftUI

struct CalendarIntakeView: View {
    let outerCircleDiameter: CGFloat = 35
    let innerCircleDiameter: CGFloat = 28
    let daysInWeek = 7
    
    var calendar: Calendar

    private var weekDayFormatter: DateFormatter {
        let dateFormatter = DateFormatter(dateFormat: "EEEEE", calendar: calendar)
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])
        return dateFormatter
    }
    private var fullFormatter: DateFormatter {
        DateFormatter(dateFormat: "MMMM dd, yyyy", calendar: calendar)
    }

    @Binding var selectedDay: Date
    @State private var monthStart = Self.now
    private static var now = Date() // Cache now
    var days: [Date] {
        makeDays()
    }
    var startDate: Date?
    var endDate: Date?
    
    @State var reminder: Reminder
    
    func takenIntakes(for day: Date) -> Int32? {
        return reminder.dailyIntakes?.filter({ dailyIntake in
            calendar.isDate(dailyIntake.date!, inSameDayAs: day)
        }).first?.takenDailyIntakes
    }
    
    func dayTotalIntakes(for day: Date) -> Int32? {
        return reminder.dailyIntakes?.filter({ dailyIntake in
            calendar.isDate(dailyIntake.date!, inSameDayAs: day)
        }).first?.todayTotalIntakes
    }
    
    func isIntakeDay(for day: Date) -> Bool {
        let totalIntakes = reminder.dailyIntakes?.filter({ dailyIntake in
            calendar.isDate(dailyIntake.date!, inSameDayAs: day)
        }).first?.todayTotalIntakes ?? 0
        
        return totalIntakes > 0
    }

    var body: some View {
        VStack {
            VStack{
                LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
                    Section {
                        ForEach(days.prefix(daysInWeek), id: \.self) { day in
                            Text(weekDayFormatter.string(from: day))
                        }
                        ForEach(days, id: \.self) { day in
                            if calendar.isDate(day, equalTo: monthStart, toGranularity: .month) && isIntakeDay(for: day) {
                                CalendarIntakeDayView(calendar: calendar, day: day, selectedDay: $selectedDay, reminder: reminder)
                            } else {
                                CalendarIntakeTrailingView(calendar: calendar, day: day)
                            }
                        }
                    } header: {
                        CalendarIntakeHeaderView(calendar: calendar, monthStart: $monthStart)
                    }
                }
            }
        }
        .padding()
    }
}


private extension CalendarIntakeView {
    func makeDays() -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: monthStart),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
        else {
            return []
        }

        let dateInterval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
        return calendar.generateDays(for: dateInterval)
    }
}


// MARK: - Previews
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarIntakeView(calendar: Calendar(identifier: .gregorian), selectedDay: .constant(Date.now), startDate: Date(timeIntervalSinceNow: -5616000), endDate: Date(timeIntervalSinceNow: -345600), reminder: Reminder(context: PersistenceController.preview.container.viewContext))
            .environmentObject(ThemeSettings())
    }
}
