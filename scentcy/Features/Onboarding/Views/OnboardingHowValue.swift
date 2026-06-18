//
//  OnboardingHowValue.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingHowValue: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

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
            .padding(Constants.UI.defaultPadding)
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
                    .foregroundStyle(Color.primary.opacity(0.7))
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 32)

            PrimaryButton(title: "Done", backgroundColor: .appButton) {
                hasCompletedOnboarding = true
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, Constants.UI.screenPadding)
        .onboardingToolbar(currentPage: 4)
    }
}

#Preview {
    NavigationStack {
        OnboardingHowValue()
    }
}
