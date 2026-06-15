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
    var isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // Perfume image placeholder
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.appGray.opacity(0.3))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: "camera")
                            .foregroundColor(.gray.opacity(0.4))
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text(perfumeName)
                        .font(Typography.bodyStrong)
                        .foregroundColor(.black)

                    Text(brandName)
                        .font(Typography.body)
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
