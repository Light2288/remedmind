import SwiftUI

struct CalendarIntakeView: View {
    let outerCircleDiameter: CGFloat = 35
    let innerCircleDiameter: CGFloat = 28
    let daysInWeek = 7
    let calendar: Calendar = Calendar.customLocalizedCalendar
    var startDate: Date?
    var endDate: Date?

    @Binding var selectedDay: Date
    @State private var monthStart = Date.now
    @State var reminder: Reminder
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var days: [Date] {
        makeDays()
    }
    
    var body: some View {
        VStack {
            VStack{
                LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
                    Section {
                        ForEach(days.prefix(daysInWeek), id: \.self) { day in
                            Text(DateFormatter.weekDayFormatter.string(from: day))
                        }
                        ForEach(days, id: \.self) { day in
                            if calendar.isDate(day, equalTo: monthStart, toGranularity: .month) && reminder.isIntakeDay(for: day) {
                                IntakeDayView(text: DateFormatter.dayFormatter.string(from: day), outerCircleDiameter: outerCircleDiameter, innerCircleDiameter: innerCircleDiameter, day: day, onButtonTap: { selectedDay = day }, selectedDayTextColor: themeSettings.selectedThemeSecondaryColor, selectedDay: $selectedDay, reminder: reminder)
                            } else {
                                NoIntakeDayView(text: DateFormatter.dayFormatter.string(from: day), frameSize: outerCircleDiameter, day: day)
                            }
                        }
                    } header: {
                        CalendarIntakeHeaderView(calendar: calendar, monthStart: $monthStart)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            monthStart = selectedDay
        }
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
        CalendarIntakeView(startDate: Date(timeIntervalSinceNow: -5616000), endDate: Date(timeIntervalSinceNow: -345600), selectedDay: .constant(Date.now), reminder: Reminder(context: PersistenceController.preview.container.viewContext))
            .environmentObject(ThemeSettings())
    }
}
