//
//  ScentProfileCard.swift
//  scentcy
//
// Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI

struct ScentProfileCard: View {
    @State private var isRevealed: Bool = false
    @State private var dragOffset: CGFloat = 0
    @State private var glitterParticles: [GlitterParticle] = []
    @State private var descriptionOpacity: Double = 0
    @State private var descriptionOffset: CGFloat = 12

    let scentType: String = "Charismatic"
    let description: String = "You are a warm and inviting person with a fragrance of sweet and floral notes that draw people in effortlessly."

    var body: some View {
        // Single unified card
        VStack(alignment: .leading, spacing: 0) {

            // MARK: - Top section: YOU'RE Charismatic
            VStack(alignment: .leading, spacing: 2) {
                Text("YOU'RE")
                    .font(Typography.label)
                    .foregroundStyle(Color.primary.opacity(0.5))
                    .kerning(1.4)

                Text(scentType)
                    .font(.system(size: 32, weight: .bold, design: .serif))
                    .italic()
                    .foregroundStyle(Color.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(Color.appSecondary)

            // MARK: - Divider
            Rectangle()
                .fill(Color.primary.opacity(0.06))
                .frame(height: 1)

            // MARK: - Bottom section: Swipe or Description
            ZStack {
                if isRevealed {
                    Text(description)
                        .font(Typography.body)
                        .foregroundStyle(Color.primary)
                        .lineSpacing(5)
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(descriptionOpacity)
                        .offset(y: descriptionOffset)
                        .onAppear {
                            withAnimation(.easeOut(duration: 0.5)) {
                                descriptionOpacity = 1
                                descriptionOffset = 0
                            }
                        }
                } else {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.appSecondary)
                                .frame(width: 36, height: 36)
                            Image(systemName: "arrow.right")
                                .foregroundStyle(Color.primary)
                                .font(.system(size: 13, weight: .semibold))
                        }
                        .offset(x: dragOffset * 0.9)

                        Text("Swipe to reveal")
                            .font(Typography.bodyStrong)
                            .foregroundStyle(Color.primary)
                            .opacity(max(0, 1 - Double(dragOffset) / 90))

                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 18)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if value.translation.width > 0 {
                                    dragOffset = min(value.translation.width, 110)
                                }
                            }
                            .onEnded { value in
                                if value.translation.width > 80 {
                                    triggerReveal()
                                } else {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                        dragOffset = 0
                                    }
                                }
                            }
                    )
                }

                // Glitter overlay
                ForEach(glitterParticles) { particle in
                    GlitterParticleView(particle: particle)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 76)
            .background(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.07), radius: 10, x: 0, y: 3)
    }

    private func triggerReveal() {
        glitterParticles = (0..<60).map { _ in GlitterParticle() }

        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
            isRevealed = true
            dragOffset = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            glitterParticles = []
        }
    }
}

// MARK: - Glitter Particle Model
struct GlitterParticle: Identifiable {
    let id = UUID()
    let x: CGFloat = CGFloat.random(in: 20...340)
    let y: CGFloat = CGFloat.random(in: 10...70)
    let size: CGFloat = CGFloat.random(in: 3...8)
    let color: Color = [
        Color(hex: "FF6EB4"),
        Color(hex: "FFB3D9"),
        Color(hex: "FF3D8B"),
        Color(hex: "FFC0E8"),
        Color(hex: "FF85C2"),
        Color(hex: "FFADD6"),
        Color.white,
    ].randomElement()!
    let delay: Double = Double.random(in: 0...0.45)
    let driftX: CGFloat = CGFloat.random(in: -25...25)
    let driftY: CGFloat = CGFloat.random(in: -40...(-10))
}

// MARK: - Glitter Particle View
struct GlitterParticleView: View {
    let particle: GlitterParticle
    @State private var opacity: Double = 0
    @State private var scale: CGFloat = 0
    @State private var offset: CGSize = .zero

    var body: some View {
        Circle()
            .fill(particle.color)
            .frame(width: particle.size, height: particle.size)
            .blur(radius: particle.size * 0.15)
            .opacity(opacity)
            .scaleEffect(scale)
            .position(x: particle.x + offset.width, y: particle.y + offset.height)
            .onAppear {
                // Pop in
                withAnimation(
                    .spring(response: 0.3, dampingFraction: 0.5)
                    .delay(particle.delay)
                ) {
                    opacity = 0.9
                    scale = 1.0
                }
                // Float up and fade
                withAnimation(
                    .easeInOut(duration: 0.9)
                    .delay(particle.delay + 0.2)
                ) {
                    offset = CGSize(width: particle.driftX, height: particle.driftY)
                    opacity = 0
                    scale = 0.4
                }
            }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 4) {
        Text("Your Scent Profile")
            .font(Typography.display)
        Text("Based on your sniffing journey")
            .font(Typography.notes)
            .foregroundStyle(Color.textGray)

        ScentProfileCard()
            .padding(.top, 8)
    }
    .padding()
    .background(Color.appBackground)
}
