//
//  scentcyApp.swift
//  scentcy
//
//  Created by Zildjian Vito  on 03/06/26.
//

import SwiftUI
import SwiftData

@main
struct scentcyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                OnboardingWhat()
                    .onAppear {
                        // Seed dummy data if database is empty
                        DataManager.shared.seedDataIfNeeded()
                    }
            }
        }
        .modelContainer(DataManager.shared.modelContainer)
    }
}
