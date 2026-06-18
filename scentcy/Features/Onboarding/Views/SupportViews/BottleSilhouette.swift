//
//  BottleSilhouette.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 15/06/26.
//

import SwiftUI

struct BottleSilhouette: View {
    var body: some View {
        VStack(spacing: 2) {
            // Cap
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.primary)
                .frame(width: 28, height: 20)

            // Neck
            Rectangle()
                .fill(Color.primary.opacity(0.5))
                .frame(width: 40, height: 4)

            // Bottle body
            RoundedRectangle(cornerRadius: 14)
                .strokeBorder(Color.primary, lineWidth: 2.5)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.appCardBackground)
                )
                .frame(width: 64, height: 80)
                .overlay(
                    Text("SI")
                        .font(.system(.caption2, weight: .heavy))
                        .tracking(2)
                        .foregroundStyle(Color.primary.opacity(0.4))
                )
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.appBackground.opacity(0.6))
        )
    }
}

#Preview {
    BottleSilhouette()
        .padding()
        .background(Color.appBackground)
}
