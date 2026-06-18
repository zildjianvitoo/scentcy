//
//  OnboardingHow.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingHow: View {
    @Binding var currentPage: Int
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
                    .foregroundStyle(Color.black.opacity(0.7))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 32)

            // Next button — disabled until scan completes
            PrimaryButton(title: "Next", backgroundColor: .appButton) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    currentPage += 1
                }
            }
            .opacity(scanComplete ? 1.0 : 0.4)
            .disabled(!scanComplete)
            .animation(.easeOut(duration: 0.4), value: scanComplete)
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 20)
        .onboardingToolbar(currentPage: $currentPage)
    }
}

#Preview {
    NavigationStack {
        OnboardingHow(currentPage: .constant(2))
    }
}
