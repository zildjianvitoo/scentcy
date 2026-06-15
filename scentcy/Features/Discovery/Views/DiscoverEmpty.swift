//
//  DiscoverEmpty.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI

struct DiscoverEmpty: View {
    var onTakePicture: () -> Void = {}

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                Text("Discover")
                    .font(Typography.display)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                Spacer()

                VStack(spacing: 16) {
                    Image("snap_empty")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)

                    VStack(spacing: 16) {
                        Text("Find your next favourite bottle")
                            .font(Typography.sectionTitle)
                            .foregroundStyle(Color.primary)
                            .multilineTextAlignment(.center)

                        Text("Snap a **perfume you love** and\nwe'll find your next obsession")
                            .font(Typography.body)
                            .foregroundStyle(Color.black)
                            .multilineTextAlignment(.center)
                            .lineSpacing(3)
                    }

                    Button(action: onTakePicture) {
                        Text("Take picture")
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
                    .padding(.top, 24)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)

                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    DiscoverEmpty()
}
