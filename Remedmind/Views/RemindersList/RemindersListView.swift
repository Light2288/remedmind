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
    @EnvironmentObject var iconSettings: IconNames
    @EnvironmentObject var themeSettings: ThemeSettings
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Reminder.startDate, ascending: false)],
        animation: .default)
    private var reminders: FetchedResults<Reminder>
    
    @State var isAddReminderViewPresented: Bool = false
    @State var isSettingsViewPresented: Bool = false
    @State var addButtonOffset = CGSize(width: 100, height: -50)
    @State var addButtonOpacity = 1.0
    @State var addButtonPlusSymbolOpacity = 1.0
    @State var navigationBarAddButtonOpacity = 0.0
    @State var addButtonPlusSymbolColor = Color(.systemBackground)
    @State var addButtonPlusSymbolScale = CGSize(width: 0.75, height: 0.75)
    @State var tag = 0
    @State var selectedDay: Date = Date.now
    @State var selectedReminder: Reminder?
    @State var showAddIntakeOverlayView: Bool = false
    
    var body: some View {
        ZStack {
        NavigationView {
                List {
                    ForEach(reminders) { reminder in
                        NavigationLink {
                            ReminderDetailView(reminder: reminder)
                        } label: {
                            ReminderListRowView(reminder: reminder, selectedReminder: $selectedReminder, selectedDay: $selectedDay, showAddIntakeOverlayView: $showAddIntakeOverlayView)
                                .environmentObject(self.themeSettings)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .onAppear(perform: {
                    reminders.forEach { reminder in
                        reminder.addMissingDailyIntakes(context: viewContext)
                        if reminder.activeAdministrationNotification {
                            LocalNotifications.shared.deleteAndCreateNewNotificationRequests(for: reminder)
                        }
                    }
                })
                .simultaneousGesture(
                    DragGesture(minimumDistance: 25).onChanged { value in
                        withAnimation(.easeOut(duration: 0.8)) {
                            self.tag = 1
                            addButtonOffset = CGSize(
                                width: 0,
                                height: 0)
                            addButtonOpacity = 0.0
                            addButtonPlusSymbolColor = ThemeSettings().selectedThemePrimaryColor
                            addButtonPlusSymbolScale = CGSize(width: 0.66, height: 0.66)
                            
                        }
                        
                        withAnimation(.easeIn(duration: 0.1).delay(0.7)) {
                            addButtonPlusSymbolOpacity = 0.0
                        }
                        
                        withAnimation(.default.delay(0.7)) {
                            navigationBarAddButtonOpacity = 1.0
                        }
                    }
                )
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            isAddReminderViewPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .background(PositionReader(tag: 1, value: .center))
                        .opacity(navigationBarAddButtonOpacity)
                        .onAppear {
                            _ = self.tag(1)
                        }
                        
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isSettingsViewPresented.toggle()
                        } label: {
                            Image(systemName: "gear")
                        }
                        
                    }
                }
                .sheet(isPresented: $isAddReminderViewPresented, onDismiss: {
                    reminders.forEach { reminder in
                        reminder.addMissingDailyIntakes(context: viewContext)
                    }
                }) {
                    AddEditReminderView(showModal: $isAddReminderViewPresented)
                        .environment(\.managedObjectContext, viewContext)
                        .environmentObject(self.themeSettings)
                }
                .sheet(isPresented: $isSettingsViewPresented) {
                    SettingsView(showSettingsModal: $isSettingsViewPresented)
                        .environmentObject(self.iconSettings)
                        .environmentObject(self.themeSettings)
                }
                //            }
                .background(PositionReader(tag: 0, value: .bottomTrailing))
                .navigationTitle("Promemoria medicine")
                .navigationBarTitleDisplayMode(.large)
                .overlayPreferenceValue(Positions.self) { preferences in
                    GeometryReader { proxy in
                        let position = self.getPosition(proxy: proxy, tag: self.tag, preferences: preferences)
                        AddReminderButton(isAddReminderViewPresented: $isAddReminderViewPresented, offset: $addButtonOffset, buttonOpacity: $addButtonOpacity, plusSymbolColor: $addButtonPlusSymbolColor, plusSymbolScale: $addButtonPlusSymbolScale, plusSymbolOpacity: $addButtonPlusSymbolOpacity)
                            .position( x: position.x - 2, y: position.y + 3)
                        
                    }
                }
                
            }
            if let _ = $selectedReminder.wrappedValue, showAddIntakeOverlayView {
                ReminderListAddIntakeOverlayView(selectedReminder: $selectedReminder, selectedDay: $selectedDay, showAddIntakeOverlayView: $showAddIntakeOverlayView)
            }
        }
        .tint(themeSettings.selectedThemePrimaryColor)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { reminders[$0] }.forEach { reminder in
                LocalNotifications.shared.deleteAllNotificationRequests(for: reminder, { reminder in
                    DispatchQueue.main.async{
                        viewContext.delete(reminder)
                        do {
                            try viewContext.save()
                        } catch {
                            // Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    }
                })
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
