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

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Reminder.id, ascending: true)],
        animation: .default)
    private var reminders: FetchedResults<Reminder>
    
    @State private var isAddReminderViewPresented: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(reminders) { reminder in
                    NavigationLink {
                        Text("Reminder for medicine \(reminder.medicineName!)")
                    } label: {
                        Text("\(reminder.id!) \(reminder.medicineName!) \(reminder.medicineBrand!)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        isAddReminderViewPresented.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                    .sheet(isPresented: $isAddReminderViewPresented) {
                        AddReminderView(showModal: $isAddReminderViewPresented)
                            .environment(\.managedObjectContext, viewContext)
                    }

                }
            }
            .navigationTitle("Promemoria medicine")
            .navigationBarTitleDisplayMode(.large)
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
    }
}
