//
//  MetricPairCard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 15/06/26.
//

import SwiftUI

struct MetricPairCard: View {
    let leftIcon: String
    let leftLabel: String
    let leftValue: String
    let rightIcon: String
    let rightLabel: String
    let rightValue: String

    var body: some View {
        HStack(spacing: 0) {
            // Left
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: leftIcon)
                        .font(.system(.caption))
                        .foregroundColor(.black.opacity(0.5))

                    Text(leftLabel)
                        .font(Typography.detailPerfume)
                        .foregroundColor(.black.opacity(0.5))
                }

                Text(leftValue)
                    .font(Typography.bodyStrong)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.vertical, Constants.UI.defaultPadding)

            Divider()
                .frame(width: 1)
                .background(Color.appButton.opacity(0.3))

            // Right
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: rightIcon)
                        .font(.system(.caption))
                        .foregroundColor(.black.opacity(0.5))

                    Text(rightLabel)
                        .font(Typography.detailPerfume)
                        .foregroundColor(.black.opacity(0.5))
                }

                Text(rightValue)
                    .font(Typography.bodyStrong)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.vertical, Constants.UI.defaultPadding)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.appCardBackground)
                .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Color.appButton.opacity(0.4), lineWidth: 1)
                )
        )
    }
}

#Preview {
    MetricPairCard(
        leftIcon: "hourglass",
        leftLabel: "Longevity",
        leftValue: "8 hrs",
        rightIcon: "wave.3.right",
        rightLabel: "Sillage",
        rightValue: "Moderate"
    )
    .padding()
    .background(Color.appBackground)
}
