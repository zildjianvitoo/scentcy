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
            Text("Is this the perfume you mean?")
                .font(Typography.detailPerfume)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.top, 32)
                .padding(.bottom, 24)

            // Perfume image card
            perfumeImage
                .resizable()
                    .scaledToFit()
                    .frame(width: 116, height: 173)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(hex: "F8F7F4"))
                            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 1)
                )
                .padding(.bottom, 20)

            // Perfume info
            VStack(spacing: 4) {
                Text(perfumeName)
                    .font(Typography.titleSubheadline)
                    .foregroundColor(.black)

                Text(brandName)
                    .font(Typography.detailPerfume)
                    .foregroundColor(.black)
            }
            .padding(.bottom, 32)

            Spacer()

            // Buttons
            HStack(spacing: 12) {
                Button(action: onNo) {
                    Text("No")
                        .font(Typography.detailPerfume)
                        .foregroundColor(.black)
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
                        .foregroundColor(.black)
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
        .padding(.horizontal, 24)
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
