//
//  RemedmindApp.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/11/22
//

import SwiftUI

@main
struct RemedmindApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RemindersListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(IconNames())
                .environmentObject(ThemeSettings())
        }
    }
}
