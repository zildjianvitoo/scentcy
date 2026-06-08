//
//  PreviouslySniffedCard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI

struct PreviouslySniffedCard: View {
    let data: SniffedPerfume

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(data.perfumeName)
                        .font(Typography.bodyStrong)
                        .foregroundStyle(Color.primary)

                    Text(data.brandName)
                        .font(Typography.label)
                        .foregroundStyle(Color.textGray)
                }

                HStack(spacing: 8) {
                    ForEach(data.tags, id: \.self) { tag in
                        TagChip(label: tag)
                    }
                }
            }

            Spacer()

            Image(data.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 90)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    PreviouslySniffedCard(data: SniffedPerfume.dummySample)
        .padding()
        .background(Color.appBackground)
}
