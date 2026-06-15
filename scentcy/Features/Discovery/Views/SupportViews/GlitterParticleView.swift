//
//  GlitterParticleView.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import SwiftUI

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
                withAnimation(
                    .spring(response: 0.3, dampingFraction: 0.5)
                    .delay(particle.delay)
                ) {
                    opacity = 0.9
                    scale = 1.0
                }
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
    GlitterParticleView(particle: GlitterParticle())
        .frame(width: 400, height: 200)
}
