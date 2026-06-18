//
//  OnboardingWhat.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingWhat: View {
    @Binding var currentPage: Int

    // Separate state per element
    @State private var bottleFloat  = false
    @State private var roseFloat    = false
    @State private var muskFloat    = false
    @State private var woodFloat    = false
    @State private var citrusFloat  = false
    @State private var ringRotation = false
    @State private var showContent  = false

    var body: some View {
        VStack(spacing: 0) {

            Spacer()

            // Hero illustration
            ZStack {
                // Outer subtle glow
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.appSecondary.opacity(0.15),
                                Color.appPrimary.opacity(0.08),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 20,
                            endRadius: 120
                        )
                    )
                    .frame(width: 224, height: 224)
                    .blur(radius: 16)

                // Pink particle bloom — behind everything else
                ScentBloom()

                // Outer orbital ring
                Circle()
                    .strokeBorder(style: StrokeStyle(lineWidth: 0.5, dash: [4, 4]))
                    .foregroundStyle(Color.primary.opacity(0.05))
                    .frame(width: 220, height: 220)
                    .rotationEffect(.degrees(ringRotation ? 360 : 0))

                // Inner orbital ring
                Circle()
                    .strokeBorder(lineWidth: 0.5)
                    .foregroundStyle(Color.primary.opacity(0.06))
                    .frame(width: 160, height: 160)
                    .rotationEffect(.degrees(ringRotation ? -360 : 0))

                // Bottle — bigger float: ±14pt
                BottleSilhouette()
                    .frame(width: 80, height: 128)
                    .offset(y: bottleFloat ? -14 : 14)
                    .shadow(color: .black.opacity(0.03), radius: 8, y: 4)

                // ROSE pill — bigger drift: ±10pt
                FloatingPill(label: "🌹 ROSE", background: Color.appPrimary, borderColor: Color.appPrimary.opacity(0.7))
                    .offset(x: -90, y: -85)
                    .offset(x: roseFloat ? 8 : -4, y: roseFloat ? -10 : 4)

                // MUSK pill
                FloatingPill(label: "🪵 MUSK", background: .white, borderColor: Color.primary.opacity(0.1))
                    .offset(x: 90, y: -70)
                    .offset(x: muskFloat ? -8 : 5, y: muskFloat ? 8 : -10)

                // WOOD pill
                FloatingPill(label: "🌲 WOOD", background: Color.appSecondary.opacity(0.4), borderColor: Color.appSecondary.opacity(0.6))
                    .offset(x: -95, y: 80)
                    .offset(x: woodFloat ? 10 : -5, y: woodFloat ? 8 : -8)

                // CITRUS pill
                FloatingPill(label: "🍋 CITRUS", background: Color.appPrimary, borderColor: Color.appPrimary.opacity(0.7))
                    .offset(x: 95, y: 75)
                    .offset(x: citrusFloat ? -8 : 6, y: citrusFloat ? -8 : 6)
            }
            .frame(height: 280)

            Spacer()

            // Title + description
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Find Your Next Bottle,")
                        .font(Typography.display)
                        .foregroundStyle(Color.primary)

                    Text("Effortlessly.")
                        .font(Typography.display)
                        .italic()
                        .underline()
                        .foregroundStyle(Color.appSecondary)
                }

                Text("Forget complex perfumes theories. Discover new perfumes based on what you love.")
                    .font(Typography.body)
                    .foregroundStyle(Color.black.opacity(0.7))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 32)
            .opacity(showContent ? 1 : 0)
            .offset(y: showContent ? 0 : 15)

            // Button
            PrimaryButton(
                title: "See how it works!",
                backgroundColor: .appButton
            ) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    currentPage += 1
                }
            }
            .opacity(showContent ? 1 : 0)
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 20)
        .onboardingToolbar(currentPage: $currentPage)
        .onAppear {
            startAllAnimations()
        }
    }

    // MARK: - Animations
    // Each element gets its own explicit withAnimation call so SwiftUI
    // can't mix up which animation applies to which state change.

    private func startAllAnimations() {
        // Content entrance — one-shot, no repeat
        withAnimation(.easeOut(duration: 0.6)) {
            showContent = true
        }

        // Orbital rings — slow continuous rotation
        withAnimation(.linear(duration: 40).repeatForever(autoreverses: false)) {
            ringRotation = true
        }

        // Bottle — gentle bob, starts immediately
        withAnimation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true)) {
            bottleFloat = true
        }

        // Pills — staggered starts so they feel organic
        withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
            roseFloat = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 4.5).repeatForever(autoreverses: true)) {
                muskFloat = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.easeInOut(duration: 5.5).repeatForever(autoreverses: true)) {
                woodFloat = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            withAnimation(.easeInOut(duration: 4.8).repeatForever(autoreverses: true)) {
                citrusFloat = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        OnboardingWhat(currentPage: .constant(1))
    }
}
