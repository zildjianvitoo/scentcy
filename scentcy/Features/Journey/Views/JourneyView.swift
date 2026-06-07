//
//  JourneyView.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI

enum JourneyTab {
    case sniffed, saved
}

// MARK: - Dummy Data
struct JourneyPerfume: Identifiable {
    let id = UUID()
    let name: String
    let brand: String
    let imageName: String
    var isSaved: Bool = false
}

let dummySniffed: [JourneyPerfume] = [
    JourneyPerfume(name: "Rose 31",      brand: "Le Labo",   imageName: "rose31"),
    JourneyPerfume(name: "Eau Capitale", brand: "Diptyque",  imageName: "eaucapitale"),
    JourneyPerfume(name: "Rose 31",      brand: "Le Labo",   imageName: "rose31"),
    JourneyPerfume(name: "Eau Capitale", brand: "Diptyque",  imageName: "eaucapitale"),
]

let dummySaved: [JourneyPerfume] = [
    JourneyPerfume(name: "Libre",        brand: "YSL",       imageName: "libre",       isSaved: true),
    JourneyPerfume(name: "My Way",       brand: "Armani",    imageName: "myway",       isSaved: true),
]

// MARK: - JourneyView
struct JourneyView: View {
    @State private var selectedTab: JourneyTab = .sniffed

    var currentList: [JourneyPerfume] {
        selectedTab == .sniffed ? dummySniffed : dummySaved
    }

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {

                // MARK: - Title
                Text("Scent Journey")
                    .font(Typography.display)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                // MARK: - Segmented Control
                SegmentedControl(selected: $selectedTab)
                    .padding(.horizontal, 20)

                // MARK: - Grid
                if currentList.isEmpty {
                    Spacer()
                    JourneyEmpty(tab: selectedTab)
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(currentList) { perfume in
                                JourneyPerfumeCard(perfume: perfume, showStar: selectedTab == .saved)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                    }
                }            }
        }
    }
}

// MARK: - Segmented Control
struct SegmentedControl: View {
    @Binding var selected: JourneyTab

    var body: some View {
        HStack(spacing: 0) {
            SegmentButton(title: "Sniffed", isSelected: selected == .sniffed) {
                withAnimation(.easeInOut(duration: 0.2)) { selected = .sniffed }
            }
            SegmentButton(title: "Saved", isSelected: selected == .saved) {
                withAnimation(.easeInOut(duration: 0.2)) { selected = .saved }
            }
        }
        .background(Color.primary.opacity(0.06))
        .clipShape(Capsule())
    }
}

struct SegmentButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Typography.bodyStrong)
                .foregroundStyle(Color.primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    isSelected
                        ? Color.white.clipShape(Capsule())
                        : Color.clear.clipShape(Capsule())
                )
                .padding(3)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Journey Perfume Card
struct JourneyPerfumeCard: View {
    let perfume: JourneyPerfume
    let showStar: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                // Image container
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.white)

                    Image(perfume.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 140)
                        .padding(12)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 170)

                // Star badge (saved tab only)
                if showStar {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.85))
                            .frame(width: 30, height: 30)
                        Image(systemName: "star.fill")
                            .font(.system(size: 13))
                            .foregroundStyle(Color.primary.opacity(0.3))
                    }
                    .padding(10)
                }
            }

            // Text
            VStack(alignment: .leading, spacing: 2) {
                Text(perfume.name)
                    .font(Typography.titlePerfume)
                    .foregroundStyle(Color.primary)
                    .lineLimit(1)

                Text(perfume.brand)
                    .font(Typography.description)
                    .foregroundStyle(Color.textGray)
                    .lineLimit(1)
            }
            .padding(.horizontal, 2)
        }
    }
}

#Preview {
    JourneyView()
}

