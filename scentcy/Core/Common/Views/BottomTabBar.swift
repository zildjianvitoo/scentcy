//
//  BottomTabBar.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import SwiftUI

struct BottomTabBar: View {
    @State private var selectedTab: TabItem = .discover
    @State private var isShowingCamera = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            // MARK: - Native TabView
            TabView(selection: $selectedTab) {
                NavigationStack {
                    HomeView()
                }
                .tag(TabItem.discover)
                .tabItem {
                    Label(TabItem.discover.title, systemImage: TabItem.discover.icon)
                        .environment(\.symbolVariants, selectedTab == .discover ? .fill : .none)
                }
                
                NavigationStack {
                    JourneyView()
                }
                .tag(TabItem.journey)
                .tabItem {
                    Label(TabItem.journey.title, systemImage: TabItem.journey.icon)
                        .environment(\.symbolVariants, selectedTab == .journey ? .fill : .none)
                }
            }
            .tint(Color.black) // Native behavior: Active tab icon/text becomes black
            
            // MARK: - Camera FAB
            CameraFloatingButton {
                isShowingCamera = true
            }
            .padding(.trailing, Constants.UI.largePadding)
            .padding(.bottom, 80)
        }
        .toolbar(.hidden, for: .navigationBar)
        .fullScreenCover(isPresented: $isShowingCamera) {
            CameraView()
        }
    }
}

#Preview {
    BottomTabBar()
}
