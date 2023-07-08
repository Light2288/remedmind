//
//  RemedmindApp.swift
//  Remedmind
//
//  Created by Davide Aliti on 28/11/22
//

import SwiftUI
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        
        GADMobileAds.sharedInstance().start()
        
        return true
    }
}

@main
struct RemedmindApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RemindersListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(IconSettings())
                .environmentObject(ThemeSettings())
                .environmentObject(AppearanceSettings())
                .onAppear {
                    let scenes = UIApplication.shared.connectedScenes
                    let windowScenes = scenes.first as? UIWindowScene
                    let window = windowScenes?.windows.first
                    window?.overrideUserInterfaceStyle = AppearanceSettings().selectedAppearance
                }
        }
    }
}
