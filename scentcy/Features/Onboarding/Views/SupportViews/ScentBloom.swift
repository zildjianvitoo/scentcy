//
//  ScentBloom.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 15/06/26.
//
//  Animated pink particle bloom placed behind the bottle in OnboardingWhat.
//  Each particle has its own @State so animations are fully independent
//  and never interfere with each other.
//

import SwiftUI

struct ScentBloom: View {

    // MARK: - Per-particle animation states
    @State private var p0 = false
    @State private var p1 = false
    @State private var p2 = false
    @State private var p3 = false
    @State private var p4 = false
    @State private var p5 = false
    @State private var p6 = false
    @State private var p7 = false

    // MARK: - Palette
    private let blush  = Color(red: 1.00, green: 0.80, blue: 0.86)   // soft blush
    private let rose   = Color(red: 1.00, green: 0.67, blue: 0.76)   // rose
    private let petal  = Color(red: 0.98, green: 0.85, blue: 0.90)   // very pale petal

    var body: some View {
        ZStack {
            // Particle 0 — top, large blush
            particle(color: blush, size: 20, angle: 15,  radius: 72, blur: 5.0, animate: p0)

            // Particle 1 — upper-right, medium rose
            particle(color: rose,  size: 14, angle: 65,  radius: 65, blur: 3.5, animate: p1)

            // Particle 2 — right, small petal
            particle(color: petal, size: 12, angle: 110, radius: 82, blur: 3.0, animate: p2)

            // Particle 3 — bottom-right, large blush
            particle(color: blush, size: 18, angle: 155, radius: 70, blur: 4.5, animate: p3)

            // Particle 4 — bottom, medium rose
            particle(color: rose,  size: 14, angle: 210, radius: 78, blur: 3.5, animate: p4)

            // Particle 5 — bottom-left, small petal
            particle(color: petal, size: 12, angle: 255, radius: 62, blur: 3.0, animate: p5)

            // Particle 6 — left, large blush
            particle(color: blush, size: 16, angle: 295, radius: 86, blur: 4.0, animate: p6)

            // Particle 7 — upper-left, small rose
            particle(color: rose,  size: 13, angle: 340, radius: 68, blur: 3.5, animate: p7)
        }
        .onAppear {
            // Each particle starts with its own withAnimation — fully independent loop
            startParticle(delay: 0.0, duration: 0.8) { p0 = true }
            startParticle(delay: 0.1, duration: 1.0) { p1 = true }
            startParticle(delay: 0.2, duration: 0.7) { p2 = true }
            startParticle(delay: 0.3, duration: 0.9) { p3 = true }
            startParticle(delay: 0.05, duration: 0.85) { p4 = true }
            startParticle(delay: 0.25, duration: 1.1) { p5 = true }
            startParticle(delay: 0.15, duration: 0.75) { p6 = true }
            startParticle(delay: 0.35, duration: 0.95) { p7 = true }
        }
    }

    // MARK: - Helpers

    /// Renders a single soft particle circle at the given polar position.
    @ViewBuilder
    private func particle(
        color: Color,
        size: CGFloat,
        angle: Double,
        radius: CGFloat,
        blur: CGFloat,
        animate: Bool
    ) -> some View {
        let rad = angle * .pi / 180
        Circle()
            .fill(color)
            .frame(width: size, height: size)
            .blur(radius: blur)
            .scaleEffect(animate ? 1.0 : 0.25)
            .opacity(animate ? 0.85 : 0.0)
            .offset(
                x: cos(rad) * radius,
                y: sin(rad) * radius
            )
    }

    /// Launches a particle's repeating bloom animation after `delay` seconds.
    private func startParticle(delay: Double, duration: Double, toggle: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation(
                .easeInOut(duration: duration)
                .repeatForever(autoreverses: true)
            ) {
                toggle()
            }
        }
    }
}

#Preview {
    ZStack {
        Color(red: 0.99, green: 0.97, blue: 0.95)
        ScentBloom()
    }
    .frame(width: 300, height: 300)
}
