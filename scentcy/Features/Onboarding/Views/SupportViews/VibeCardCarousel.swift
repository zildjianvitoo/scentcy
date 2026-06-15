//
//  VibeCardCarousel.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 15/06/26.
//
//  Auto-cycling vibe card for OnboardingHowValue.
//  Matches VibeCard design but with always-expanded notes
//  and content-only slide transitions (not the whole card).
//

import SwiftUI

struct VibeCardCarousel: View {
    private struct VibeEntry {
        let name: String
        let icon: String
        let notes: [String]
    }

    private let vibes: [VibeEntry] = [
        VibeEntry(name: "Floral", icon: "camera.macro", notes: ["Rose", "Jasmine", "Peony", "Lily", "Magnolia"]),
        VibeEntry(name: "Woody", icon: "tree.fill", notes: ["Cedar", "Sandalwood", "Vetiver", "Patchouli", "Amber"]),
        VibeEntry(name: "Fresh", icon: "wind", notes: ["Bergamot", "Lemon", "Green Apple", "Cucumber", "Mint"]),
    ]

    @State private var index = 0
    @State private var cycleTask: Task<Void, Never>?

    private var current: VibeEntry { vibes[index] }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // MARK: - Header (vibe name only)
            VStack(alignment: .leading, spacing: 4) {
                Text("Your vibe is")
                    .font(Typography.detailPerfume)
                    .foregroundStyle(Color.primary.opacity(0.6))

                Text(current.name)
                    .font(Typography.metric)
                    .foregroundStyle(Color.primary)
                    .id("name-\(index)")
                    .transition(.blurReplace)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 12)

            // MARK: - Divider with icon anchored
            Divider()
                .background(Color.primary.opacity(0.1))
                .padding(.horizontal, 20)
                .overlay(alignment: .trailing) {
                    Image(systemName: current.icon)
                        .font(.system(size: 32))
                        .foregroundStyle(Color.primary.opacity(0.12))
                        .frame(width: 40, height: 40)
                        .id("icon-\(index)")
                        .transition(.blurReplace)
                        .offset(y: -20)
                        .padding(.trailing, 20)
                }

            // MARK: - Always-expanded notes
            VStack(alignment: .leading, spacing: 12) {
                Text("Your aroma (notes)")
                    .font(Typography.detailPerfume)
                    .foregroundStyle(Color.primary)

                FlowLayout(spacing: 8) {
                    ForEach(current.notes, id: \.self) { note in
                        NoteChip(label: note)
                    }
                }
                .id("notes-\(index)")
                .transition(.blurReplace)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .frame(minHeight: 100, alignment: .topLeading)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.appPrimary)
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
        .onAppear { startCycle() }
        .onDisappear { cycleTask?.cancel() }
    }

    private func startCycle() {
        cycleTask?.cancel()
        cycleTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(2.5))
                if Task.isCancelled { break }
                await MainActor.run {
                    withAnimation(.easeInOut(duration: 0.45)) {
                        index = (index + 1) % vibes.count
                    }
                }
            }
        }
    }
}

#Preview {
    VibeCardCarousel()
        .padding()
        .background(Color.appBackground)
}
