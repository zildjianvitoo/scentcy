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
            Image("perfumeNotFound")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding(.top, 32)
                

            VStack(alignment: .leading, spacing: 8) {
                Text("Perfume Not Found!")
                    .font(Typography.screenTitle)
                    .foregroundColor(.primary)

                Text("Try a clearer shot, or snap a different bottle")
                    .font(Typography.body)
                    .foregroundColor(.black.opacity(0.8))
                    .lineSpacing(4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)

            Spacer()

            PrimaryButton(title: "Try Again", textColor: .white, action: onTryAgain)
                .padding(.bottom, 32)
        }
        .padding(.horizontal, Constants.UI.largePadding)
        .background(Color.appBackground)
    }
}

#Preview {
    PerfumeNotFoundSheet(onTryAgain: {})
}
