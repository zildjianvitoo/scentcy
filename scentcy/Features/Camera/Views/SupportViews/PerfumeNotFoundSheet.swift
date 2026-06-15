//
//  PerfumeNotFoundSheet.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 12/06/26.
//

import SwiftUI

struct PerfumeNotFoundSheet: View {
    var onTryAgain: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Image("not_found_empty")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 136)
                .padding(.top, 32)
                .padding(.bottom, 24)

            VStack(alignment: .leading, spacing: 8) {
                Text("Perfume Not Found!")
                    .font(Typography.sectionTitle)
                    .foregroundColor(.black)

                Text("Try a clearer shot, or snap a different bottle")
                    .font(Typography.body)
                    .foregroundColor(.black.opacity(0.8))
                    .lineSpacing(4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)

            Spacer()

            PrimaryButton(title: "Try Again", action: onTryAgain)
                .padding(.bottom, 32)
        }
        .padding(.horizontal, 24)
        .background(Color.appBackground)
    }
}

#Preview {
    PerfumeNotFoundSheet(onTryAgain: {})
}
