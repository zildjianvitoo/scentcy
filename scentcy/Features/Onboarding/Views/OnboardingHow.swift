//
//  OnboardingHow.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingHow: View {
    @State private var navigateToResult = false
    var body: some View {
        VStack(spacing: 40) {

            VStack(spacing: 40) {
                HStack {
                    Image(.onboardingWhat)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 357)
                        .clipped()
                        .cornerRadius(Constants.UI.cornerRadius)
                }

                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Share Perfumes")
                            .font(Typography.display)
                        HStack {
                            Text("You")
                                .font(Typography.display)
                            Text("Enjoy")
                                .font(Typography.display)
                                .italic()
                                .foregroundColor(.highlitedText)
                        }

                    }

                    Text(
                        "Upload perfumes you've smelled and liked. We'll learn your scent preferences from there."
                    )
                    .font(Typography.body)

                    Spacer()

                    PrimaryButton(title: "Next", backgroundColor: .appButton) {
                        navigateToResult = true
                    }
                    .navigationDestination(isPresented: $navigateToResult) {
                        OnboardingHowResult()
                    }
                }
                

            }

        }
        .padding(20)
        .background(Color.appBackground)
        .onboardingToolbar(currentPage: 2)

    }

}

#Preview {
    OnboardingHow()
}
