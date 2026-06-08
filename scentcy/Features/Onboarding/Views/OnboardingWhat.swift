//
//  OnboardingWhat.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingWhat: View {
    @State private var navigateToHow = false
    var body: some View {
        VStack(spacing: 40) {

            Spacer()

            VStack(spacing: 40) {
                HStack {
                    Image(systemName: "zzz")
                        .frame(width: 177, height: 150)
                        .background(Color.gray.opacity(0.2))
                    Spacer()
                }

                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Find Your Next Bottle,")
                            .font(Typography.display)
                        Text("Effortlessly.")
                            .font(Typography.display)
                            .foregroundStyle(Color.appSecondary)
                            .italic()
                            .underline()
                    }

                    Text(
                        "Forget complex perfumes theories. Discover new perfumes based on what you love."
                    )
                    .font(Typography.body)
                }
            }

            Spacer()

            PrimaryButton(
                title: "See how it works!",
                backgroundColor: .appButton
            ) {
                navigateToHow = true
            }
            .navigationDestination(isPresented: $navigateToHow) {
                OnboardingHow()
            }
        }
        .padding(20)
        .background(Color.appBackground)
        .onboardingToolbar(currentPage: 1)
    }
}

#Preview {
    NavigationStack {
        OnboardingWhat()
    }
}
