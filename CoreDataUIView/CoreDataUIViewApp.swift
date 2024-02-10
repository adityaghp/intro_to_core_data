//
//  CoreDataUIViewApp.swift
//  CoreDataUIView
//
//  Created by Aditya Ghorpade on 08/02/24.
//

import SwiftUI

@main
struct CoreDataUIViewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
