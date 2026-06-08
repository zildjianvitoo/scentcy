//
//  OnboardingHowResult.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingHowResult: View {
    @State private var navigateToValue = false
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

                VStack(alignment: .leading,spacing: 16 ) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Get")
                                .font(Typography.display)
                            Text("Personalized")
                                .font(Typography.display)
                                .foregroundStyle(.highlitedText)
                        }

                        Text("Recommendations")
                            .font(Typography.display)

                    }
                    Text(
                        "Discover new perfumes chosen based on\nthe scents you've liked before."
                    )
                    .font(Typography.body)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()

                    PrimaryButton(title: "Next", backgroundColor: .appButton) {
                        navigateToValue = true
                    }
                    .navigationDestination(isPresented: $navigateToValue) {
                        OnboardingHowValue()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }

        }
        .padding(20)
        .background(Color.appBackground)
        .onboardingToolbar(currentPage: 3)
    }
}

#Preview {
    OnboardingHowResult()
}
