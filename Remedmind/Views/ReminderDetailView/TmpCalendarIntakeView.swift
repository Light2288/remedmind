import SwiftUI

struct TmpCalendarIntakeView: View {
    var outerCircleDiameter: CGFloat = 35
    var innerCircleDiameter: CGFloat = 28
    
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var calendar: Calendar
    private var monthYearFormatter: DateFormatter {
        DateFormatter(dateFormat: "MMMM yyyy", calendar: calendar)
    }
    private var monthFormatter: DateFormatter {
        DateFormatter(dateFormat: "MMMM", calendar: calendar)
    }
    private var dayFormatter: DateFormatter {
        DateFormatter(dateFormat: "d", calendar: calendar)
    }
    private var weekDayFormatter: DateFormatter {
        let dateFormatter = DateFormatter(dateFormat: "EEEEE", calendar: calendar)
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])
        return dateFormatter
    }
    private var fullFormatter: DateFormatter {
        DateFormatter(dateFormat: "MMMM dd, yyyy", calendar: calendar)
    }

    @State private var selectedDate = Self.now
    @State private var monthStart = Self.now
    private static var now = Date() // Cache now

    var body: some View {
        VStack {
            Text("Selected date: \(fullFormatter.string(from: selectedDate)) \(monthStart)")
                .bold()
                .foregroundColor(.red)
            TmpCalendarView(
                calendar: calendar,
                date: $monthStart,
                selectedDate: $selectedDate,
                content: { date in
                    Button {
                        selectedDate = date
                    } label: {
                        ZStack {
                            Group {
                                Circle()
                                    .fill(themeSettings.selectedThemePrimaryColor)
                                    .frame(width: outerCircleDiameter, height: outerCircleDiameter, alignment: .center)
                                Circle()
                                    .fill(Color(.systemBackground))
                                    .frame(width: innerCircleDiameter, height: innerCircleDiameter, alignment: .center)
                            }
                            Text(dayFormatter.string(from: date))
                                .foregroundColor(
                                    calendar.isDateInToday(date) ? themeSettings.selectedThemeSecondaryColor
                                    : Color(.label)
                                )
                        }
                    }

                },
                trailing: { date in
                    Text(dayFormatter.string(from: date))
                        .foregroundColor(.secondary)
                },
                header: { date in
                    Text(weekDayFormatter.string(from: date))
                },
                title: { date in
                    HStack {
                        Text(monthYearFormatter.string(from: date))
                            .font(.headline)
                            .padding()
                        Spacer()
                        Button {
                            withAnimation {
                                guard let newDate = calendar.date(
                                    byAdding: .month,
                                    value: -1,
                                    to: monthStart
                                ) else {
                                    return
                                }
                                
                                monthStart = newDate.startOfMonth(using: calendar)
                            }
                        } label: {
                            Label(
                                title: { Text("Previous") },
                                icon: { Image(systemName: "chevron.left") }
                            )
                            .labelStyle(IconOnlyLabelStyle())
                            .padding(.horizontal)
                            .frame(maxHeight: .infinity)
                        }
                        Button {
                            withAnimation {
                                guard let newDate = calendar.date(
                                    byAdding: .month,
                                    value: 1,
                                    to: monthStart
                                ) else {
                                    return
                                }
                                monthStart = newDate.startOfMonth(using: calendar)
                            }
                        } label: {
                            Label(
                                title: { Text("Next") },
                                icon: { Image(systemName: "chevron.right") }
                            )
                            .labelStyle(IconOnlyLabelStyle())
                            .padding(.horizontal)
                            .frame(maxHeight: .infinity)
                        }
                    }
                    .padding(.bottom, 6)
                }
            )
            .equatable()
        }
        .padding()
    }
}

// MARK: - Component

public struct TmpCalendarView<Day: View, Header: View, Title: View, Trailing: View>: View {
    
    var calendar: Calendar
    @Binding var date: Date
    @Binding var selectedDate: Date
    var content: (Date) -> Day
    var trailing: (Date) -> Trailing
    var header: (Date) -> Header
    var title: (Date) -> Title

    // Constants
    private let daysInWeek = 7

    public var body: some View {
        let month = date.startOfMonth(using: calendar)
        let days = makeDays()

        return VStack{
            LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
                Section(header: title(month)) {
                    ForEach(days.prefix(daysInWeek), id: \.self, content: header)
                    ForEach(days, id: \.self) { date in
                        if calendar.isDate(date, equalTo: month, toGranularity: .month) && date < Date() {
                            content(date)
                        } else {
                            trailing(date)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Conformances

extension TmpCalendarView: Equatable {
    public static func == (lhs: TmpCalendarView<Day, Header, Title, Trailing>, rhs: TmpCalendarView<Day, Header, Title, Trailing>) -> Bool {
        lhs.calendar == rhs.calendar && lhs.date == rhs.date
    }
}

private extension TmpCalendarView {
    func makeDays() -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
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
struct TmpCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        TmpCalendarIntakeView(calendar: Calendar(identifier: .gregorian))
            .environmentObject(ThemeSettings())
    }
}
