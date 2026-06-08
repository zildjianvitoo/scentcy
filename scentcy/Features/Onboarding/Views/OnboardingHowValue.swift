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
        VStack(spacing: 40) {

            VStack(spacing: 40) {
                HStack {
                    Image(.illustResult)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 357)
                        .clipped()
                        .cornerRadius(Constants.UI.cornerRadius)
                }

                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading) {

                        Text("Meet Your Scent")
                            .font(Typography.display)

                        Text("Personality")
                            .font(Typography.display)
                            .italic()
                            .foregroundStyle(Color.highlitedText)
                    }
                    Text(
                        "See the scent traits that best describe\nyour perfume taste."
                    )
                    .font(Typography.body)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()

                    PrimaryButton(title: "Next", backgroundColor: .appButton) {
                        navigateToContent = true
                    }
                    .navigationDestination(isPresented: $navigateToContent) {
                        BottomTabBar()
                            .navigationBarBackButtonHidden(true)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            }

        }
        .padding(20)
        .background(Color.appBackground)
        .onboardingToolbar(currentPage: 4)
    }
}

#Preview {
    OnboardingHowValue()
}
