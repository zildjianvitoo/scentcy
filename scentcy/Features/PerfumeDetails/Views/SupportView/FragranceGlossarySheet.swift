//
//  FragranceGlossarySheet.swift
//  scentcy
//
//  Created by Zildjian Vito on 15/06/26.
//

import SwiftUI

struct FragranceGlossarySheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 24) {
                // Drag indicator spacer (if we use native drag indicator, we just need padding)
                Spacer().frame(height: 10)

                Text("Fragrance Glossary")
                    .font(Typography.bodyStrong)
                    .foregroundColor(.black)
                    .padding(.top, 16)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        GlossaryCard(
                            title: "Longevity",
                            icon: "hourglass",
                            bodyText: "How long the scent stays on your skin.",
                            thinkOfItAs: "“How many hours can I still smell this?”",
                            extraText: nil
                        )

                        GlossaryCard(
                            title: "Sillage",
                            icon: "wind",
                            bodyText: "How far the scent spreads around you.",
                            thinkOfItAs: "“How big is my scent bubble?”",
                            extraText: "Intimate = only people close to you notice it\nModerate = people nearby can smell it\nStrong = leaves a noticeable scent trail"
                        )

                        GlossaryCard(
                            title: "Notes",
                            icon: "sparkles",
                            bodyText: "The individual scents that make up the perfume, like ingredients in a recipe.",
                            thinkOfItAs: "“What does this perfume smell like?”",
                            extraText: nil
                        )
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                }

                Button(action: {
                    dismiss()
                }) {
                    Text("Got it!")
                        .font(Typography.bodyStrong)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.appButton)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
        .presentationDetents([.fraction(0.85), .large])
        .presentationDragIndicator(.visible)
    }
}

fileprivate struct GlossaryCard: View {
    let title: String
    let icon: String
    let bodyText: String
    let thinkOfItAs: String
    let extraText: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 8) {
                Circle()
                    .fill(Color(hex: "E1B376"))
                    .frame(width: 6, height: 6)

                Text(title)
                    .font(Typography.bodyStrong)
                    .foregroundColor(.black)

                Spacer()

                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(Color.appButton.opacity(0.6))
            }

            VStack(alignment: .leading, spacing: 12) {
                Text(bodyText)
                    .font(Typography.body)
                    .foregroundColor(.black)
                    .lineSpacing(4)

                if let extraText = extraText {
                    Text(extraText)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.black)
                        .lineSpacing(4)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("Think of it as:")
                        .font(Typography.body)
                        .foregroundColor(.black)
                    Text(thinkOfItAs)
                        .font(Typography.body)
                        .italic()
                        .foregroundColor(.black)
                }
            }
            .padding(.leading, 14) // Indent to align with text
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Color.appButton.opacity(0.4), lineWidth: 1)
                )
        )
    }
}

#Preview {
    Text("Preview")
        .sheet(isPresented: .constant(true)) {
            FragranceGlossarySheet()
        }
}
