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
        sortDescriptors: [NSSortDescriptor(keyPath: \Reminder.startingDate, ascending: false)],
        animation: .default)
    private var reminders: FetchedResults<Reminder>
    
    @State private var isAddReminderViewPresented: Bool = false
    @State private var isSettingsViewPresented: Bool = false
    @State private var animatingPlusButton: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(reminders) { reminder in
                        NavigationLink {
                            Text("Reminder for medicine \(reminder.medicineName ?? "Unknown")")
                        } label: {
                            ReminderListRowView(reminder: reminder)
                                .environmentObject(self.themeSettings)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
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
                    AddReminderView(showModal: $isAddReminderViewPresented)
                        .environment(\.managedObjectContext, viewContext)
                        .environmentObject(self.themeSettings)
                }
                .sheet(isPresented: $isSettingsViewPresented) {
                    SettingsView(showSettingsModal: $isSettingsViewPresented)
                        .environmentObject(self.iconSettings)
                        .environmentObject(self.themeSettings)
                }
                .navigationTitle("Promemoria medicine")
                .navigationBarTitleDisplayMode(.large)
            }
            .onAppear {
                animatingPlusButton = true
            }
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(themeSettings.selectedThemeSecondaryColor)
                            .opacity(animatingPlusButton ? 0.2 : 0)
                            .scaleEffect(animatingPlusButton ? 1 : 0.1)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(themeSettings.selectedThemeSecondaryColor)
                            .opacity(animatingPlusButton ? 0.15 : 0)
                            .scaleEffect(animatingPlusButton ? 1 : 0.1)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    .animation(.easeOut(duration: 2.5).repeatForever(autoreverses: true), value: animatingPlusButton)
                    
                    Button {
                        isAddReminderViewPresented.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(themeSettings.selectedThemeSecondaryColor)
                            .background(Circle().fill(.white))
                            .frame(width: 48, height: 48, alignment: .center)
                    }
                }
                , alignment: .bottomTrailing
            )
        }
        .tint(themeSettings.selectedThemePrimaryColor)
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
