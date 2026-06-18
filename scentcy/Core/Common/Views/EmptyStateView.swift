//
//  EmptyStateView.swift
//  scentcy
//
//  Created by Antigravity
//

import SwiftUI

struct EmptyStateView: View {
    let imageName: String
    let title: String
    let subtitle: String
    var buttonTitle: String? = nil
    var buttonAction: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 16) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 160)
                .opacity(0.85)

            VStack(spacing: 12) {
                Text(title)
                    .font(Typography.sectionTitle)
                    .foregroundStyle(Color.primary)
                    .multilineTextAlignment(.center)

                Text(LocalizedStringKey(subtitle))
                    .font(Typography.body)
                    .foregroundStyle(Color.textGray)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }

            if let buttonTitle = buttonTitle, let buttonAction = buttonAction {
                Button(action: buttonAction) {
                    Text(buttonTitle)
                        .font(Typography.body)
                        .foregroundStyle(Color.primary.opacity(0.75))
                        .frame(width: 183, height: 43)
                        .background(
                            RoundedRectangle(cornerRadius: 29.09)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color(hex: "F0D9BA"),
                                            Color(hex: "E1B376")
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 29.09)
                                        .strokeBorder(Color.appButton, lineWidth: 1.21)
                                )
                        )
                }
                .padding(.top, 12)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 40)
    }
}

#Preview {
    VStack(spacing: 60) {
        EmptyStateView(
            imageName: "discoverEmpty",
            title: "Find your next favourite bottle",
            subtitle: "Snap a **perfume you love** and\nwe'll find your next obsession",
            buttonTitle: "Take picture",
            buttonAction: {}
        )
        
        EmptyStateView(
            imageName: "emptyHistory",
            title: "Your scent journey begins here",
            subtitle: "Every perfume you snap will\nbe safely stored here."
        )
    }
    .padding()
}
