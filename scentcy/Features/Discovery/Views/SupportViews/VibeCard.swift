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
                    Text("Your vibe is")
                        .font(Typography.detailPerfume)
                        .foregroundStyle(Color.primary.opacity(0.6))

                    Text(vibeName)
                        .font(Typography.metric)
                        .foregroundStyle(Color.primary)
                }

                Spacer()

                Image(systemName: vibeIcon)
                    .font(.system(size: 48))
                    .foregroundStyle(Color.primary.opacity(0.12))
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 16)

            Divider()
                .background(Color.primary.opacity(0.1))
                .padding(.horizontal, 20)

            DisclosureGroup {
                FlowLayout(spacing: 8) {
                    ForEach(aromaNotes, id: \.self) { note in
                        NoteChip(label: note)
                    }
                }
                .padding(.top, 12)
                .padding(.bottom, 4)
            } label: {
                Text("Your aroma (notes)")
                    .font(Typography.detailPerfume)
                    .foregroundStyle(Color.primary)
            }
            .tint(Color.primary.opacity(0.6))
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
