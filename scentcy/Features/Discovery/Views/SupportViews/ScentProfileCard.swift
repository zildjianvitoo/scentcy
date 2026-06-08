//
//  ScentProfileCard.swift
//  scentcy
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
        VStack(alignment: .leading, spacing: 0) {

            // MARK: - Top section
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

            // MARK: - Bottom section
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
                                .fill(.ultraThinMaterial)
                                .frame(width: 32, height: 32)
                                .overlay(Circle().fill(Color.babyBlue.opacity(0.45)))
                                .overlay(Circle().stroke(Color.white.opacity(0.6), lineWidth: 1))
                                .shadow(color: Color.babyBlue.opacity(0.3), radius: 4, x: 0, y: 2)

                            Image(systemName: "arrow.right")
                                .foregroundStyle(Color.primary)
                                .font(Typography.label)
                        }
                        .offset(x: dragOffset * 0.9)

                        Text("Swipe to reveal")
                            .font(Typography.bodyStrong)
                            .foregroundStyle(Color.primary)
                            .opacity(max(0, 1 - Double(dragOffset) / 90))

                        Spacer()
                    }
                    .padding(.horizontal, 2)
                    .padding(.vertical, 4)
                    .background(RoundedRectangle(cornerRadius: 24).fill(Color.babyBlue.opacity(0.95)))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
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
