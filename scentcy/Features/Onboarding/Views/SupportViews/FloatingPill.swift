//
//  FloatingPill.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 15/06/26.
//

import SwiftUI

struct FloatingPill: View {
    let label: String
    let background: Color
    let borderColor: Color

    var body: some View {
        Text(label)
            .font(.system(size: 10, weight: .bold))
            .tracking(1.5)
            .foregroundStyle(Color.primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(background)
                    .overlay(
                        Capsule()
                            .strokeBorder(borderColor, lineWidth: 1)
                    )
            )
            .shadow(color: .black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    VStack(spacing: 16) {
        FloatingPill(label: "ROSE", background: Color.appPrimary, borderColor: Color.appPrimary.opacity(0.7))
        FloatingPill(label: "MUSK", background: .white, borderColor: Color.primary.opacity(0.1))
        FloatingPill(label: "WOOD", background: Color.appSecondary.opacity(0.4), borderColor: Color.appSecondary.opacity(0.6))
        FloatingPill(label: "CITRUS", background: Color.appPrimary, borderColor: Color.appPrimary.opacity(0.7))
    }
    .padding()
    .background(Color.appBackground)
}
