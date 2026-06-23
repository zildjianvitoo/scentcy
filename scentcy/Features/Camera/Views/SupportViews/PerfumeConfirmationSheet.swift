//
//  PerfumeConfirmationSheet.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 12/06/26.
//

import SwiftUI

struct PerfumeConfirmationSheet: View {
    var perfumeName: String
    var brandName: String
    var perfumeImage: Image
    var onNo: () -> Void
    var onYes: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Text("Is this the correct perfume?")
                .font(Typography.detailPerfume)
                .foregroundColor(.primary)  
                .multilineTextAlignment(.center)
                .padding(.top, 32)
                .padding(.bottom, Constants.UI.largePadding)

            // Perfume image card
            perfumeImage
                .resizable()
                    .scaledToFit()
                    .frame(width: 116, height: 173)
                    .padding(Constants.UI.defaultPadding)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.appCardBackground)
                            .shadow(color: Color.primary.opacity(0.25), radius: 2, x: 0, y: 1)
                )
                .padding(.bottom, Constants.UI.screenPadding)

            // Perfume info
            VStack(spacing: 4) {
                Text(perfumeName)
                    .font(Typography.titleSubheadline)
                    .foregroundColor(.primary)

                Text(brandName)
                    .font(Typography.detailPerfume)
                    .foregroundColor(.primary)
            }
            .padding(.bottom, 32)

            Spacer()

            // Buttons
            HStack(spacing: 12) {
                Button(action: onNo) {
                    Text("No")
                        .font(Typography.detailPerfume)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            Capsule()
                                .fill(Color.appGray.opacity(0.5))
                        )
                }

                Button(action: onYes) {
                    Text("Yes, it is")
                        .font(Typography.detailPerfume)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            Capsule()
                                .fill(Color.appButton)
                        )
                }
            }
            .padding(.bottom, 32)
        }
        .padding(.horizontal, Constants.UI.largePadding)
        .background(Color.appBackground)
    }
}

#Preview {
    PerfumeConfirmationSheet(
        perfumeName: "Libre Intense EDP",
        brandName: "Yves Saint Laurent",
        perfumeImage: Image("YSL_Libre"),
        onNo: {},
        onYes: {}
    )
}
