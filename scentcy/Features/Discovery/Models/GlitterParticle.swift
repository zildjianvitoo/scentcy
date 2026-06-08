//
//  GlitterParticle.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import SwiftUI

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
