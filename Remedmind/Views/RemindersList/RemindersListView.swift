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
    @State var addButtonOffset = CGSize(width: 100, height: 0)
    @State var addButtonOpacity = 1.0
    @State var addButtonPlusSymbolOpacity = 1.0
    @State var navigationBarAddButtonOpacity = 0.0
    @State var addButtonPlusSymbolColor = Color(.systemBackground)
    @State var addButtonPlusSymbolScale = CGSize(width: 0.75, height: 0.75)
    
    let buttonSize: CGFloat = 70 //Constant to move the button to the toolbar leading element position
    
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
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
                        .onDelete(perform: deleteItems)
                    }
                    .gesture(
                        DragGesture().onChanged { value in
                            withAnimation(.easeIn(duration: 0.8)) {
                                addButtonOffset = CGSize(
                                    width: -proxy.size.width + buttonSize - proxy.safeAreaInsets.leading,
                                    height: -proxy.size.height + proxy.safeAreaInsets.top)
                                addButtonOpacity = 0.0
                                addButtonPlusSymbolColor = ThemeSettings().selectedThemePrimaryColor
                                addButtonPlusSymbolScale = CGSize(width: 0.66, height: 0.66)
                                
                            }
                            
                            withAnimation(.easeOut(duration: 0.03).delay(0.78)) {
                                addButtonPlusSymbolOpacity = 0.0
                            }
                            
                            withAnimation(.default.delay(0.8)) {
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
                                .opacity(navigationBarAddButtonOpacity)
                                
                            }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                isSettingsViewPresented.toggle()
                            } label: {
                                Image(systemName: "gear")
                            }
                            
                        }
                    }
                    .sheet(isPresented: $isAddReminderViewPresented) {
                        AddEditReminderView(showModal: $isAddReminderViewPresented)
                            .environment(\.managedObjectContext, viewContext)
                            .environmentObject(self.themeSettings)
                    }
                    .sheet(isPresented: $isSettingsViewPresented) {
                        SettingsView(showSettingsModal: $isSettingsViewPresented)
                            .environmentObject(self.iconSettings)
                            .environmentObject(self.themeSettings)
                    }
                }
                .navigationTitle("Promemoria medicine")
                .navigationBarTitleDisplayMode(.large)
                .overlay(alignment: .bottomTrailing, content: {
                    AddReminderButton(isAddReminderViewPresented: $isAddReminderViewPresented, offset: $addButtonOffset, buttonOpacity: $addButtonOpacity, plusSymbolColor: $addButtonPlusSymbolColor, plusSymbolScale: $addButtonPlusSymbolScale, plusSymbolOpacity: $addButtonPlusSymbolOpacity)
                })
            }
            .tint(themeSettings.selectedThemePrimaryColor)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { reminders[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
