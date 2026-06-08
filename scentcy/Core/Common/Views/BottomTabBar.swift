//
//  BottomTabBar.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import SwiftUI

struct BottomTabBar: View {
    @State private var selectedTab: TabItem = .discover

    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            // MARK: - Native TabView
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(TabItem.discover)
                    .tabItem {
                        Label(TabItem.discover.title, systemImage: TabItem.discover.icon)
                    }
                JourneyView()
                    .tag(TabItem.journey)
                    .tabItem {
                        Label(TabItem.journey.title, systemImage: TabItem.journey.icon)
                        
                    }
            }
            .tint(Color.babyBlue)
            .tabBarMinimizeBehavior(.onScrollDown)  // iOS 18+ liquid glass native
            

            // MARK: - Camera FAB
            Button {
                // action kamera
            } label: {
                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .overlay {
                            Circle()
                                .fill(Color.babyBlue.opacity(0.55))
                        }
                        .overlay {
                            Circle()
                                .stroke(Color.white.opacity(0.7), lineWidth: 1)
                        }
                        .shadow(color: Color.babyBlue.opacity(0.35), radius: 10, x: 0, y: 4)
                        .frame(width: 52, height: 52)

                    Image(systemName: "camera")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(Color.primary)
                }
            }
            .padding(.trailing, 24)
            .padding(.bottom, 80)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    BottomTabBar()
}
