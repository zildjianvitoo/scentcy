//
//  scentcyApp.swift
//  scentcy
//
//  Created by Zildjian Vito  on 03/06/26.
//

import SwiftUI
import SwiftData

@main
struct ScentcyApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                BottomTabBar()
                    .onAppear {
                        DataManager.shared.seedDataIfNeeded()
                    }
            } else {
                OnboardingContainer()
                    .onAppear {
                        DataManager.shared.seedDataIfNeeded()
                    }
            }
        }
        .modelContainer(DataManager.shared.modelContainer)
    }
}
