//
//  PerfumeCard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 14/06/26.
//

import SwiftUI

struct PerfumeCard: View {
    let data: Perfume
    var showStar: Bool = false

    private let scentNotes = ["Woody", "Citrusy"]
    private let occasionTag = "Day & Night"
    private let moodTag = "Formal"

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Perfume image
            ZStack(alignment: .topTrailing) {
                Image(data.name)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 130)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color(hex: "F6F6F6"))
                    .clipShape(RoundedRectangle(cornerRadius: 14))

                if showStar {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "E1B376"))
                        .frame(width: 26, height: 26)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                        .padding(10)
                }
            }
            .padding(.horizontal, 4)
            .padding(.top, 4)

            // Name + brand
            VStack(alignment: .leading, spacing: 2) {
                Text(data.name)
                    .font(Typography.titleSubheadline)
                    .foregroundStyle(Color.primary)
                    .lineLimit(1)

                Text(data.brand)
                    .font(Typography.detailPerfume)
                    .foregroundStyle(Color.primary)
                    .lineLimit(1)
            }

            // Scent notes
            HStack(spacing: 8) {
                ForEach(scentNotes, id: \.self) { note in
                    Text("•\(note)")
                        .font(Typography.scentNotes)
                        .foregroundStyle(Color.black)
                }
            }

            // Occasion + mood tags (stacked vertical)
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 10))
                        .foregroundStyle(Color(hex: "0080FF"))
                    Text(occasionTag)
                        .font(Typography.scentNotes)
                }
                .foregroundStyle(Color.primary)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(Color.babyBlue.opacity(0.6))
                )

                HStack(spacing: 4) {
                    Image(systemName: "suitcase.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(Color(hex: "E77D0C"))
                    Text(moodTag)
                        .font(Typography.scentNotes)
                }
                .foregroundStyle(Color.primary)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(Color.appPrimary.opacity(0.6))
                )
            }
        }
        .padding(12)
        .frame(width: 170)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 3)
    }
}

#Preview {
    HStack(spacing: 12) {
        PerfumeCard(data: perfumeDataArray[0])
        PerfumeCard(data: perfumeDataArray[1], showStar: true)
    }
    .padding()
    .background(Color.appBackground)
}
