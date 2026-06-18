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
                    .font(.system(.largeTitle))
                    .foregroundStyle(Color.primary.opacity(0.12))
            }
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.top, Constants.UI.screenPadding)
            .padding(.bottom, Constants.UI.defaultPadding)

            Divider()
                .background(Color.primary.opacity(0.1))
                .padding(.horizontal, Constants.UI.screenPadding)

            DisclosureGroup {
                FlowLayout(spacing: 8) {
                    ForEach(aromaNotes, id: \.self) { note in
                        ChipView(label: note, style: .note)
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
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.vertical, Constants.UI.defaultPadding)
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
