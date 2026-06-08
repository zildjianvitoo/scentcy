//
//  PreviouslySniffedCard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI

struct PreviouslySniffedCard: View {
    let data: Perfume

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(data.name)
                        .font(Typography.bodyStrong)
                        .foregroundStyle(Color.primary)

                    Text(data.brand)
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

            Image(data.name)
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
    PreviouslySniffedCard(data: perfumeDataArray[1])
        .padding()
        .background(Color.appBackground)
}
