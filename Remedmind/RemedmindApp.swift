//
//  RemedmindApp.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/11/22.
//

import SwiftUI

@main
struct RemedmindApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
