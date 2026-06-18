//
//  DetailSectionCard.swift
//  scentcy
//
//  Created by Afra on 18/06/26.
//

import SwiftUI

struct DetailSectionCard<Content: View>: View {
    let title: String
    var onTap: (() -> Void)? = nil
    @ViewBuilder let content: Content

    var body: some View {
        Button(action: { onTap?() }) {
            VStack(spacing: 0) {
                // Header
                HStack(spacing: 6) {
                    Text(title)
                        .font(Typography.bodyStrong)
                        .foregroundColor(.primary)
                    
//                    if onTap != nil {
//                        Image(systemName: "info.circle")
//                            .font(.system(size: 14))
//                            .foregroundColor(.black.opacity(0.4))
//                    }
                    
                    Spacer()
                    Circle()
                        .fill(Color.appButton)
                        .frame(width: 8, height: 8)
                }
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.vertical, 14)
            .background(Color.appCardBackground)

            Divider()
                .background(Color.appButton.opacity(0.3))

            // Content
            content
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
        }
        }
        .buttonStyle(.plain)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.appButton.opacity(0.4), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 2)
    }
}

#Preview {
    DetailSectionCard(title: "Performance") {
        MetricPairCard(
            leftIcon: "hourglass",
            leftLabel: "Longevity",
            leftValue: "8 hrs",
            rightIcon: "wave.3.right",
            rightLabel: "Sillage",
            rightValue: "Moderate"
        )
    }
    .padding()
    .background(Color.appBackground)
}
