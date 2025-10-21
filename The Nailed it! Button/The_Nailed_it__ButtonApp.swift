//
//  The_Nailed_it__ButtonApp.swift
//  The Nailed it! Button
//
//  Created by Michael Fluharty on 10/21/25.
//

import SwiftUI
import SwiftData

@main
struct The_Nailed_it__ButtonApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
