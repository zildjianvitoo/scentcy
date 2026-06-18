//
//  OnboardingHow.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingHow: View {
    @State private var navigateToResult = false
    @State private var scanComplete = false

    var body: some View {
        VStack(spacing: 0) {

            // Scanner illustration — auto-plays scan animation
            ScannerCard(isScanComplete: $scanComplete)
                .padding(.top, 8)

            Spacer()

            // Title + description
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Share Perfumes")
                        .font(Typography.display)
                        .foregroundStyle(Color.primary)

                    HStack(spacing: 6) {
                        Text("You")
                            .font(Typography.display)
                            .foregroundStyle(Color.primary)
                        Text("Enjoy")
                            .font(Typography.display)
                            .italic()
                            .foregroundStyle(Color.appButton)
                    }
                }

                Text("Upload perfumes you've smelled and liked. We'll learn your scent preferences from there.")
                    .font(Typography.body)
                    .foregroundStyle(Color.primary.opacity(0.7))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 32)

            // Next button — disabled until scan completes
            PrimaryButton(title: "Next", backgroundColor: .appButton) {
                navigateToResult = true
            }
            .navigationDestination(isPresented: $navigateToResult) {
                OnboardingHowResult()
            }
            .opacity(scanComplete ? 1.0 : 0.4)
            .disabled(!scanComplete)
            .animation(.easeOut(duration: 0.4), value: scanComplete)
        }
        .padding(.horizontal, 32)
        .padding(.vertical, Constants.UI.screenPadding)
        .onboardingToolbar(currentPage: 2)
    }
}

#Preview {
    NavigationStack {
        OnboardingHow()
    }
}
