//
//  JourneyPerfumeCard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import SwiftUI

struct JourneyPerfumeCard: View {
    let perfume: JourneyPerfume
    let showStar: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.white)

                    Image(perfume.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 140)
                        .padding(12)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 170)

                if showStar {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.85))
                            .frame(width: 30, height: 30)
                        Image(systemName: "star.fill")
                            .font(.system(size: 13))
                            .foregroundStyle(Color.primary.opacity(0.3))
                    }
                    .padding(10)
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(perfume.name)
                    .font(Typography.titlePerfume)
                    .foregroundStyle(Color.primary)
                    .lineLimit(1)

                Text(perfume.brand)
                    .font(Typography.description)
                    .foregroundStyle(Color.textGray)
                    .lineLimit(1)
            }
            .padding(.horizontal, 2)
        }
    }
}
