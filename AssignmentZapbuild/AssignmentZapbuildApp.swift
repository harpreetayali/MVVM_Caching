//
//  AssignmentZapbuildApp.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 16/01/24.
//

import SwiftUI

@main
struct AssignmentZapbuildApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
