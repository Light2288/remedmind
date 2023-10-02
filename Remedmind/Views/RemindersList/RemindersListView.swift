//
//  ContentView.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/11/22.
//

import SwiftUI
import CoreData

struct RemindersListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var themeSettings: ThemeSettings
    @EnvironmentObject var appearanceSettings: AppearanceSettings
    @EnvironmentObject var iconSettings: IconSettings
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Reminder.startDate, ascending: false)],
        animation: .default)
    private var reminders: FetchedResults<Reminder>
    
    @State var isAddReminderViewPresented: Bool = false
    @State var isSettingsViewPresented: Bool = false
    @State var addButtonOffset = CGSize(width: 100, height: -10)
    @State var addButtonOpacity = 1.0
    @State var addButtonPlusSymbolOpacity = 1.0
    @State var addButtonPlusSymbolColor = Color(.systemBackground)
    @State var addButtonPlusSymbolScale = CGSize(width: 0.75, height: 0.75)
    
    @State private var isListViewVisible: Bool = false
    
    var body: some View {
        if self.isListViewVisible {
            ZStack {
                NavigationStack {
                    ZStack {
                        List {
                            ForEach(reminders) { reminder in
                                NavigationLink {
                                    ReminderDetailView(reminder: reminder)
                                } label: {
                                    ReminderListRowView(reminder: reminder)
                                        .environmentObject(self.themeSettings)
                                }
                            }
                        }
                        .onAppear(perform: {
                            reminders.forEach { reminder in
                                reminder.addMissingDailyIntakes(context: viewContext)
                                if reminder.activeAdministrationNotification || reminder.activeRunningLowNotification {
                                    LocalNotifications.shared.deleteAndCreateNewNotificationRequests(for: reminder)
                                }
                            }
                            LocalNotifications.shared.updateValidNotificationRequests(for: Array(reminders))
                        })
                        if reminders.count == 0 {
                            EmptyListView()
                                .onAppear {
                                    LocalNotifications.shared.deleteAllNotifications()
                                }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                isSettingsViewPresented.toggle()
                            } label: {
                                Image(systemName: "gear")
                            }
                            .transaction { transaction in
                                transaction.animation = nil
                            }
                        }
                    }
                    .sheet(isPresented: $isAddReminderViewPresented, onDismiss: {
                        reminders.forEach { reminder in
                            reminder.addMissingDailyIntakes(context: viewContext)
                        }
                    }) {
                        AddReminderView(showModal: $isAddReminderViewPresented)
                            .environment(\.managedObjectContext, viewContext)
                            .environmentObject(self.themeSettings)
                    }
                    .sheet(isPresented: $isSettingsViewPresented) {
                        SettingsView(showSettingsModal: $isSettingsViewPresented)
                            .environmentObject(self.iconSettings)
                            .environmentObject(self.themeSettings)
                            .environmentObject(self.appearanceSettings)
                            .environmentObject(self.iconSettings)
                    }
                    //            }
                    .background(PositionReader(tag: 0, value: .bottomTrailing))
                    .navigationTitle("reminder.list.title")
                    .navigationBarTitleDisplayMode(.large)
                    .overlay(alignment: .bottomTrailing) {
                        AddReminderButton(isAddReminderViewPresented: $isAddReminderViewPresented, offset: $addButtonOffset, buttonOpacity: $addButtonOpacity, plusSymbolColor: $addButtonPlusSymbolColor, plusSymbolScale: $addButtonPlusSymbolScale, plusSymbolOpacity: $addButtonPlusSymbolOpacity)
                    }
                    
                }
            }
            .tint(themeSettings.selectedThemePrimaryColor)
        } else {
            SplashScreenView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            self.isListViewVisible = true
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(ThemeSettings())
    }
}
