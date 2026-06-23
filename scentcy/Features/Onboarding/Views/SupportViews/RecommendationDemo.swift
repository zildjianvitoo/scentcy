//
//  RecommendationDemo.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 15/06/26.
//
//  Auto-playing onboarding demo for OnboardingHowResult.
//  Simulates: perfume card list → pointer taps card → detail sheet
//  slides up → pointer taps star/favorite → star glows → closes → loops.
//
//  Visually mirrors JourneyPerfumeCard + PerfumeDetailView design,
//  but uses self-contained mock data (no SwiftData dependency).
//

import SwiftUI

struct RecommendationDemo: View {

    // MARK: - Demo state
    @State private var showDetail = false
    @State private var pointerPosition: CGPoint = .zero
    @State private var pointerVisible = false
    @State private var pointerTapped = false
    @State private var highlightFirst = false
    @State private var isStarred = false
    @State private var showStarBurst = false
    @State private var demoTask: Task<Void, Never>?

    // MARK: - Mock data (mirrors JourneyPerfumeCard's visual structure)

    private struct DemoPerfume: Identifiable {
        let id = UUID()
        let name: String
        let brand: String
        let imageName: String
        let scentNotes: [String]
        let occasionTag: String
        let moodTag: String
    }

    private let demoPerfumes: [DemoPerfume] = [
        DemoPerfume(name: "Club de Nuit Intense Man", brand: "Armaf",
                    imageName: "cdnIntenseMan",
                    scentNotes: ["Citrus", "Fruity"],
                    occasionTag: "Day & Night", moodTag: "Casual"),
        DemoPerfume(name: "Eros", brand: "Versace",
                    imageName: "versaceEros",
                    scentNotes: ["Vanilla", "Aromatic"],
                    occasionTag: "Night", moodTag: "Casual"),
        DemoPerfume(name: "MYSLF", brand: "Yves Saint Laurent",
                    imageName: "yslMyslf",
                    scentNotes: ["Citrus", "White Floral"],
                    occasionTag: "Day", moodTag: "Formal"),
    ]

    var body: some View {
        ZStack(alignment: .top) {
            // Card list (mirrors JourneyPerfumeCard layout)
            VStack(alignment: .leading, spacing: 10) {
                Text("Similar Perfume")
                    .font(Typography.titleOnboard)
                    .foregroundStyle(Color.primary)
                    .padding(.bottom, 2)

                ForEach(Array(demoPerfumes.enumerated()), id: \.element.id) { index, perfume in
                    demoCard(perfume, isHighlighted: index == 0 && highlightFirst)
                }
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.appPrimary.opacity(0.10))
            )

            // Detail overlay (mirrors PerfumeDetailView layout)
            if showDetail {
                demoDetailOverlay
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(2)
            }

            // Pointer cursor
            if pointerVisible {
                pointerView
                    .zIndex(4)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear { startDemo() }
        .onDisappear { demoTask?.cancel() }
    }

    // MARK: - Card row (mirrors JourneyPerfumeCard)

    @ViewBuilder
    private func demoCard(_ perfume: DemoPerfume, isHighlighted: Bool) -> some View {
        HStack(alignment: .center, spacing: 12) {
            // Image container
            Image(perfume.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 52, height: 60)
                .padding(.vertical, 4)
                .frame(width: 60)
                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                .clipShape(RoundedRectangle(cornerRadius: 12))

            // Info column
            VStack(alignment: .leading, spacing: 4) {
                VStack(alignment: .leading, spacing: 1) {
                    Text(perfume.name)
                        .font(.system(.caption2, weight: .semibold))
                        .foregroundStyle(Color.primary)
                        .lineLimit(1)

                    Text(perfume.brand)
                        .font(.system(.caption2, weight: .medium))
                        .foregroundStyle(Color.primary.opacity(0.5))
                        .lineLimit(1)
                }

                Rectangle()
                    .fill(Color.primary.opacity(0.04))
                    .frame(width: 90, height: 1)
                    .padding(.top, 8)

                // Scent notes
                HStack(spacing: 6) {
                    ForEach(perfume.scentNotes, id: \.self) { note in
                        Text("•\(note)")
                            .font(.system(.caption2, weight: .medium))
                            .foregroundStyle(Color.primary.opacity(0.6))
                    }
                }

                // Tags row (matching JourneyPerfumeCard capsule style)
                HStack(spacing: 4) {
                    HStack(spacing: 3) {
                        Image(systemName: "clock")
                            .font(.system(.caption2))
                            .foregroundStyle(Color(red: 0, green: 0.5, blue: 1))
                        Text(perfume.occasionTag)
                            .font(.system(.caption2, weight: .medium))
                            .foregroundStyle(Color.primary)
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Capsule().fill(Color.babyBlue.opacity(0.5)))

                    HStack(spacing: 3) {
                        Image(systemName: "suitcase.fill")
                            .font(.system(.caption2))
                            .foregroundStyle(Color(red: 0.91, green: 0.49, blue: 0.05))
                        Text(perfume.moodTag)
                            .font(.system(.caption2, weight: .medium))
                            .foregroundStyle(Color.primary)
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Capsule().fill(Color.appPrimary.opacity(0.5)))
                }
            }

            Spacer(minLength: 0)
        }
        .padding(8)
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(
                    isHighlighted ? Color.primary : Color.clear,
                    lineWidth: isHighlighted ? 1.5 : 0
                )
        )
        .shadow(color: .black.opacity(0.04), radius: 6, y: 2)
    }

    // MARK: - Detail overlay (mirrors PerfumeDetailView)

    private var demoDetailOverlay: some View {
        ZStack(alignment: .top) {
            Color.appBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Hero image with gradient
                    ZStack(alignment: .top) {
                        LinearGradient(
                            colors: [
                                Color(hex: "F5E6D1"),
                                Color(hex: "F4E2CA"),
                                Color(hex: "FEFCFB")
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 260)

                        Image("cdnIntenseMan")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .padding(.top, Constants.UI.screenPadding)
                    }

                    // Info section (matching PerfumeDetailView structure)
                    VStack(spacing: 4) {
                        Text("Club de Nuit Intense Man")
                            .font(Typography.bodyStrong)
                            .foregroundColor(.primary)

                        Text("Armaf")
                            .font(Typography.body)
                            .foregroundColor(.primary)

                        HStack(spacing: 8) {
                            Text("•Citrus")
                                .font(Typography.scentNotes)
                                .foregroundStyle(.primary)
                            Text("•Fruity")
                                .font(Typography.scentNotes)
                                .foregroundStyle(.primary)
                        }
                        .padding(.top, 4)
                    }
                    .padding(.top, 8)
                    .padding(.bottom, Constants.UI.largePadding)

                    VStack(alignment: .leading, spacing: 24) {
                        // Performance
                        DetailSectionCard(title: "Performance", onTap: {}) {
                            MetricPairCard(
                                leftIcon: "hourglass",
                                leftLabel: "Longevity",
                                leftValue: "8 hrs",
                                rightIcon: "wind",
                                rightLabel: "Sillage",
                                rightValue: "Moderate"
                            )
                        }

                        // Usage
                        DetailSectionCard(title: "Usage", onTap: {}) {
                            MetricPairCard(
                                leftIcon: "clock",
                                leftLabel: "Time",
                                leftValue: "Day & Night",
                                rightIcon: "suitcase",
                                rightLabel: "Occasion",
                                rightValue: "Casual"
                            )
                        }

                        // Notes
                        DetailSectionCard(title: "Notes", onTap: {}) {
                            NotesCard(notes: ["Citrus", "Fruity", "Leather"])
                        }
                    }
                    .padding(.horizontal, Constants.UI.largePadding)
                    .padding(.bottom, 40)
                }
            }
            .ignoresSafeArea(edges: .top)

            // Floating buttons: close + star (matching PerfumeDetailView)
            HStack {
                // Close button
                Image(systemName: "xmark")
                    .font(.system(.footnote, weight: .bold))
                    .foregroundColor(.primary)
                    .frame(width: 40, height: 40)
                    .background(.regularMaterial, in: Circle())

                Spacer()

                // Star/favorite button
                ZStack {
                    Image(systemName: isStarred ? "star.fill" : "star")
                        .font(.system(.callout, weight: .semibold))
                        .foregroundColor(isStarred ? Color.appButton : .black)
                        .frame(width: 40, height: 40)
                        .background(.regularMaterial, in: Circle())

                    // Star burst particles
                    if showStarBurst {
                        ForEach(0..<6, id: \.self) { i in
                            let angle = Double(i) / 6.0 * 360.0 * .pi / 180.0
                            Text(i % 2 == 0 ? "✦" : "♥")
                                .font(.system(.caption2))
                                .foregroundStyle(Color.appButton)
                                .offset(
                                    x: cos(angle) * 18,
                                    y: sin(angle) * 18
                                )
                                .opacity(showStarBurst ? 0 : 1)
                                .scaleEffect(showStarBurst ? 1.2 : 0.3)
                                .animation(
                                    .easeOut(duration: 0.8).delay(Double(i) * 0.04),
                                    value: showStarBurst
                                )
                        }
                    }
                }
            }
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.top, Constants.UI.largePadding)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 12, y: 4)
    }

    // MARK: - Pointer

    private var pointerView: some View {
        Circle()
            .fill(Color.appPrimary.opacity(0.35))
            .frame(width: 28, height: 28)
            .overlay(
                Circle()
                    .strokeBorder(Color.appButton, lineWidth: 1.5)
            )
            .overlay(
                Circle()
                    .fill(Color.white.opacity(0.8))
                    .frame(width: 10, height: 10)
            )
            .scaleEffect(pointerTapped ? 0.7 : 1.0)
            .position(pointerPosition)
            .shadow(color: Color.appButton.opacity(0.5), radius: 8)
            .allowsHitTesting(false)
    }

    // MARK: - Demo sequence

    private func startDemo() {
        demoTask?.cancel()
        demoTask = Task {
            while !Task.isCancelled {
                // 0s–1.2s: Reset — show card list
                await reset()
                try? await Task.sleep(for: .seconds(1.2))
                if Task.isCancelled { break }

                // 1.2s–1.8s: Pointer appears, moves to first card
                await MainActor.run {
                    pointerVisible = true
                    pointerPosition = CGPoint(x: 180, y: 300)
                    withAnimation(.easeOut(duration: 0.5)) {
                        pointerPosition = CGPoint(x: 120, y: 100)
                    }
                }
                try? await Task.sleep(for: .seconds(0.6))
                if Task.isCancelled { break }

                // 1.8s–2.1s: Tap → highlight card
                await MainActor.run {
                    withAnimation(.easeInOut(duration: 0.12)) {
                        pointerTapped = true
                        highlightFirst = true
                    }
                }
                try? await Task.sleep(for: .seconds(0.25))
                if Task.isCancelled { break }

                // 2.1s–3.8s: Detail slides up, pointer hides
                await MainActor.run {
                    withAnimation(.spring(response: 0.45, dampingFraction: 0.82)) {
                        showDetail = true
                    }
                    pointerVisible = false
                    pointerTapped = false
                }
                try? await Task.sleep(for: .seconds(1.5))
                if Task.isCancelled { break }

                // 3.8s–4.4s: Pointer reappears, moves to star button
                await MainActor.run {
                    pointerVisible = true
                    pointerPosition = CGPoint(x: 160, y: 300)
                    withAnimation(.easeOut(duration: 0.5)) {
                        pointerPosition = CGPoint(x: 270, y: 28)
                    }
                }
                try? await Task.sleep(for: .seconds(0.6))
                if Task.isCancelled { break }

                // 4.4s–4.7s: Tap star → glow + burst
                await MainActor.run {
                    withAnimation(.easeInOut(duration: 0.12)) {
                        pointerTapped = true
                    }
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isStarred = true
                    }
                    showStarBurst = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        withAnimation { showStarBurst = true }
                    }
                }
                try? await Task.sleep(for: .seconds(0.3))
                if Task.isCancelled { break }

                // 4.7s–5.8s: Star glows, wait
                await MainActor.run {
                    pointerVisible = false
                    pointerTapped = false
                }
                try? await Task.sleep(for: .seconds(1.2))
                if Task.isCancelled { break }

                // 5.8s–6.5s: Close detail, reset
                await MainActor.run {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        showDetail = false
                        highlightFirst = false
                    }
                }
                try? await Task.sleep(for: .seconds(0.7))
            }
        }
    }

    @MainActor
    private func reset() {
        showDetail = false
        pointerTapped = false
        pointerVisible = false
        highlightFirst = false
        isStarred = false
        showStarBurst = false
    }
}

#Preview {
    RecommendationDemo()
        .padding(32)
        .background(Color.appBackground)
}
