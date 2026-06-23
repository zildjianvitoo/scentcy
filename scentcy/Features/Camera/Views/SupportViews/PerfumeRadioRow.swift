//
//  PerfumeRadioRow.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 12/06/26.
//

import SwiftUI

struct PerfumeRadioRow: View {
    var perfumeName: String
    var brandName: String
    var imageName: String
    var isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .background(Color.appGray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 2) {
                    Text(perfumeName)
                        .font(Typography.bodyStrong)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)

                    Text(brandName)
                        .font(Typography.body)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black.opacity(0.5))
                }

                Spacer()

                // Radio button
                Circle()
                    .fill(isSelected ? Color.appButton : Color.clear)
                    .frame(width: 22, height: 22)
                    .overlay(
                        Circle()
                            .strokeBorder(
                                isSelected ? Color.appButton : Color.appGray,
                                lineWidth: 1.5
                            )
                    )
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(isSelected ? Color.appButton.opacity(0.08) : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .strokeBorder(
                                isSelected ? Color.appButton : Color.clear,
                                lineWidth: 1
                            )
                    )
            )
        }
    }
}
