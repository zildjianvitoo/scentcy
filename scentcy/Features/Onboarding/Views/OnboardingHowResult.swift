//
//  OnboardingHowResult.swift
//  scentcy
//

import SwiftUI

struct OnboardingHowResult: View {
    @Binding var currentPage: Int

    var body: some View {
        VStack(spacing: 0) {

            RecommendationDemo()
                .padding(.top, 8)

            Spacer()

            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 6) {
                        Text("Get")
                            .font(Typography.display)
                            .foregroundStyle(Color.primary)
                        Text("Personalized")
                            .font(Typography.display)
                            .italic()
                            .foregroundStyle(Color.appButton)
                    }

                    Text("Recommendations")
                        .font(Typography.display)
                        .foregroundStyle(Color.primary)
                }

                Text("Discover new perfumes chosen based on the scents you've liked before.")
                    .font(Typography.body)
                    .foregroundStyle(Color.primary.opacity(0.7))
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 32)

            PrimaryButton(title: "Next", backgroundColor: .appButton) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    currentPage += 1
                }
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, Constants.UI.screenPadding)
        .onboardingToolbar(currentPage: $currentPage)
    }
}

#Preview {
    NavigationStack {
        OnboardingHowResult(currentPage: .constant(3))
    }
}
