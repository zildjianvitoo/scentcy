//
//  PreviouslySniffedCard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI

struct PreviouslySniffedCard: View {
    let perfumeName: String = "Le Male"
    let brandName: String = "Jean Paul Gaultier"
    let tags: [String] = ["Night", "Formal"]
    let imageName: String = "lemale"

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(perfumeName)
                        .font(Typography.bodyStrong)
                        .foregroundStyle(Color.primary)

                    Text(brandName)
                        .font(Typography.label)
                        .foregroundStyle(Color.textGray)
                }

                HStack(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        TagChip(label: tag)
                    }
                }
            }

            Spacer()

            Image(imageName)
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

// MARK: - Tag Chip
struct TagChip: View {
    let label: String

    var tagColor: Color {
        switch label.lowercased() {
        case "night":  return Color.appPrimary   // Light Blue
        case "formal": return Color.appSecondary // Light Tan/Sand
        case "day":    return Color.appPrimary
        case "casual": return Color.appSecondary
        default:       return Color.appSecondary
        }
    }

    var body: some View {
        Text(label)
            .font(Typography.label)
            .foregroundStyle(Color.primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .background(tagColor)
            .clipShape(Capsule())
    }
}

#Preview {
    PreviouslySniffedCard()
        .padding()
        .background(Color.appBackground)
}
