//
//  VibeCard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 14/06/26.
//

import SwiftUI

struct VibeCard: View {
    var vibeName: String
    var vibeIcon: String
    var aromaNotes: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Scent Signature")
                        .font(Typography.detailPerfume)
                        .foregroundStyle(Color.primary.opacity(0.6))

                    Text(vibeName)
                        .font(Typography.metric)
                        .foregroundStyle(Color.primary)
                }

                Spacer()
                Button(action: {
                    // Action to flip card
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.trianglehead.2.clockwise")
                            .font(Typography.flashcard)
                        Text("Tap card to flip & learn")
                            .font(Typography.flashcard)
                    }
                    .foregroundStyle(Color.primary.opacity(0.6))
                }
            }
            .buttonStyle(.bordered)
            .tint(Color(hex: "EEDDCC"))
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 16)

            Divider()
                .background(Color.primary.opacity(0.1))
                .padding(.horizontal, 20)

            VStack(alignment: .leading, spacing: 12) {
                Text("Your preferred scents (notes)")
                    .font(Typography.detailPerfume)
                    .foregroundStyle(Color.primary)

                FlowLayout(spacing: 8) {
                    ForEach(aromaNotes, id: \.self) { note in
                        NoteChip(label: note)
                    }
                }
                .padding(.bottom, 4)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.appPrimary)
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
    }
}

#Preview {
    VibeCard(vibeName: "Woody", vibeIcon: "tree", aromaNotes: ["Cedar", "Amber"])
        .padding()
        .background(Color.appBackground)
}
