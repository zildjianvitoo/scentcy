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
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            
            // MARK: - Native TabView
            TabView(selection: $selectedTab) {
                NavigationStack {
                    HomeView()
                }
                .tag(TabItem.discover)
                .toolbar(.hidden, for: .tabBar)
                
                NavigationStack {
                    JourneyView()
                }
                .tag(TabItem.journey)
                .toolbar(.hidden, for: .tabBar)
            }
            
            // MARK: - Custom Floating Layout
            HStack(spacing: 15) {
                // Left Section: Pill-shaped Tab Bar
                ZStack {
                    // Draggable Highlight
                    Color.appSecondary.opacity(0.5)
                        .clipShape(Capsule())
                        .frame(width: 112, height: 52)
                        .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
                        .offset(x: (selectedTab == .discover ? -52 : 52) + dragOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    // Limit dragging
                                    let maxDrag: CGFloat = 104 // Total distance
                                    let proposed = value.translation.width
                                    if selectedTab == .discover {
                                        dragOffset = min(max(proposed, -20), maxDrag + 20)
                                    } else {
                                        dragOffset = min(max(proposed, -maxDrag - 20), 20)
                                    }
                                }
                                .onEnded { value in
                                    let currentBase = selectedTab == .discover ? -52.0 : 52.0
                                    let totalOffset = currentBase + value.translation.width
                                    
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                        dragOffset = 0
                                        if totalOffset > 0 {
                                            selectedTab = .journey
                                        } else {
                                            selectedTab = .discover
                                        }
                                    }
                                }
                        )
                        .zIndex(0)

                    HStack(spacing: 40) {
                        tabButton(for: .discover)
                        tabButton(for: .journey)
                    }
                    .zIndex(1)
                }
                .padding(.horizontal, 32)
                .frame(height: 64)
                .background(.regularMaterial)
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.06), radius: 20, x: 0, y: 10)
                
                // Right Section: Camera Circle
                CameraFloatingButton {
                    isShowingCamera = true
                }
            }
            //.padding(.horizontal, Constants.UI.screenPadding)
            .padding(.bottom, -10)
        }
        .ignoresSafeArea(.keyboard)
        .toolbar(.hidden, for: .navigationBar)
        .fullScreenCover(isPresented: $isShowingCamera) {
            CameraView()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("SwitchToJourneySaved"))) { _ in
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                selectedTab = .journey
            }
        }
    }
    
    @ViewBuilder
    private func tabButton(for item: TabItem) -> some View {
        let isSelected = (selectedTab == item)
        Button(action: {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                selectedTab = item
            }
        }) {
            VStack(spacing: 2) {
                Image(systemName: item.icon)
                    .font(.system(size: 22))
                    .environment(\.symbolVariants, isSelected ? .fill : .none)
                    .foregroundColor(isSelected ? .appSecondary : Color.gray.opacity(0.8))
                Text(item.title)
                    .font(.system(size: 10, weight: isSelected ? .medium : .regular))
                    .foregroundColor(isSelected ? .black : Color.gray.opacity(0.8))
            }
            .frame(width: 64, height: 64)
            .contentShape(Capsule()) // Ensures the whole 64x64 area is tappable
            
        }
    }
}

#Preview {
    BottomTabBar()
}
