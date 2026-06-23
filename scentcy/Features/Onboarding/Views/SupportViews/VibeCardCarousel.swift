//
//  VibeCardCarousel.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 15/06/26.
//
//  Auto-cycling vibe card for OnboardingHowValue.
//  Matches VibeCard design and automatically flips to show both sides.
//

import SwiftUI

struct VibeCardCarousel: View {
    private struct VibeEntry {
        let name: String
        let icon: String
        let notes: [String]
        let explanation: String
    }

    private let vibes: [VibeEntry] = [
        VibeEntry(name: "Floral", icon: "camera.macro", notes: ["Rose", "Jasmine", "Peony", "Lily", "Magnolia"], explanation: "A soft, romantic, and classic scent family dominated by fresh blossoms."),
        VibeEntry(name: "Woody", icon: "tree.fill", notes: ["Cedar", "Sandalwood", "Vetiver", "Patchouli", "Amber"], explanation: "A deep, boozy, and woody note with sweet, oak-barrel nuances."),
        VibeEntry(name: "Fresh", icon: "wind", notes: ["Bergamot", "Lemon", "Green Apple", "Cucumber", "Mint"], explanation: "A vibrant, energetic scent family filled with zesty and aquatic freshness."),
    ]

    @State private var index = 0
    @State private var isFlipped = false
    @State private var cycleTask: Task<Void, Never>?

    private var current: VibeEntry { vibes[index] }

    var body: some View {
        ZStack {
            cardFront
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.appPrimary)
                        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
                )
                .opacity(isFlipped ? 0 : 1)
            
            cardBack
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
                )
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .onAppear { startCycle() }
        .onDisappear { cycleTask?.cancel() }
    }
    
    // MARK: - Front Card
    private var cardFront: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Scent Signature")
                        .font(Typography.detailPerfume)
                        .foregroundStyle(Color.primary.opacity(0.6))

                    Text(current.name)
                        .font(Typography.metric)
                        .foregroundStyle(Color.primary)
                }

                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "arrow.trianglehead.2.clockwise")
                        .font(Typography.flashcard)
                    Text("Tap card to flip & learn")
                        .font(Typography.flashcard)
                }
                .foregroundStyle(Color.primary.opacity(0.6))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(hex: "EEDDCC").opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 16)

            Divider()
                .background(Color.primary.opacity(0.1))
                .padding(.horizontal, Constants.UI.screenPadding)

            VStack(alignment: .leading, spacing: 12) {
                Text("Your preferred scents (notes)")
                    .font(Typography.detailPerfume)
                    .foregroundStyle(Color.primary)

                FlowLayout(spacing: 8) {
                    ForEach(current.notes, id: \.self) { note in
                        ChipView(label: note, style: .note)
                    }
                }
                .padding(.bottom, 4)
            }
            .tint(Color.primary.opacity(0.6))
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.vertical, Constants.UI.defaultPadding)
            .frame(minHeight: 100, alignment: .topLeading)
        }
    }
    
    // MARK: - Back Card
    private var cardBack: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("What is")
                        .font(Typography.detailPerfume)
                        .foregroundStyle(Color.primary.opacity(0.6))
                        .italic(true)
                    Text(current.name)
                        .font(Typography.metric)
                        .foregroundStyle(Color.primary)
                }

                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "arrow.trianglehead.2.clockwise")
                        .font(Typography.flashcard)
                    Text("Tap to Flip back")
                        .font(Typography.flashcard)
                }
                .foregroundStyle(Color.primary.opacity(0.6))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.primary.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.top, Constants.UI.screenPadding)
            .padding(.bottom, Constants.UI.defaultPadding)

            Divider()
                .background(Color.primary.opacity(0.1))
                .padding(.horizontal, Constants.UI.screenPadding)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(current.explanation)
                    .lineLimit(4)
                    .font(Typography.detailPerfume)
                    .foregroundStyle(Color.primary.opacity(0.8))
                    .padding(.bottom, 4)
                HStack {
                    Spacer()
                    Image(systemName: current.icon)
                        .font(.system(size: 48))
                        .foregroundStyle(Color.primary.opacity(0.12))
                }
            }
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.vertical, Constants.UI.defaultPadding)
            .frame(minHeight: 100, alignment: .topLeading)
        }
    }

    private func startCycle() {
        cycleTask?.cancel()
        cycleTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(2.5))
                if Task.isCancelled { break }
                await MainActor.run {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        if isFlipped {
                            // When flipping back to front, change the content
                            index = (index + 1) % vibes.count
                        }
                        isFlipped.toggle()
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
