//
//  OnboardingHowValue.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingHowValue: View {
    @State private var navigateToContent = false

    var body: some View {
        VStack(spacing: 0) {

            Spacer()

            // Section header + cycling vibe card
            VStack(alignment: .leading, spacing: 8) {
                Text("Your Perfume Vibe")
                    .font(Typography.metric)
                    .foregroundStyle(Color.primary)

                Text("Built from perfumes you snaped")
                    .font(Typography.detailPerfume)
                    .foregroundStyle(Color.textGray)

                VibeCardCarousel()
                    .padding(.top, 4)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white.opacity(0.4))
            )

            Spacer()

            // Title + description
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Meet Your Scent")
                        .font(Typography.display)
                        .foregroundStyle(Color.primary)

                    Text("Preferences")
                        .font(Typography.display)
                        .italic()
                        .foregroundStyle(Color.appButton)
                }

                Text("See the scent traits that best describe your perfume taste.")
                    .font(Typography.body)
                    .foregroundStyle(Color.black.opacity(0.7))
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 32)

            PrimaryButton(title: "Next", backgroundColor: .appButton) {
                navigateToContent = true
            }
            .navigationDestination(isPresented: $navigateToContent) {
                BottomTabBar()
                    .navigationBarBackButtonHidden(true)
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 20)
        .background(Color.appBackground)
        .onboardingToolbar(currentPage: 4)
    }
}

#Preview {
    NavigationStack {
        OnboardingHowValue()
    }
}
