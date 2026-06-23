//
//  Perfumecard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI

struct PerfumeCard: View {
    let data: Perfume
    var showStar: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                // Image container
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(UIColor { tc in tc.userInterfaceStyle == .dark ? UIColor(white: 0.15, alpha: 1) : UIColor(hex: "F8F7F4") }))
                        .frame(width: 140, height: 150)

                    Image(data.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 130)
                }
                
                if showStar {
                    Image(systemName: "star.fill")
                        .font(.system(.footnote))
                        .foregroundColor(Color(red: 0.88, green: 0.78, blue: 0.60)) // Gold color
                        .frame(width: 28, height: 28)
                        .background(Color.appCardBackground)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                        .padding(8)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(data.name)
                    .font(Typography.bodyStrong)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text(data.brand)
                    .font(Typography.body)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
            
            Divider()
                .background(Color.gray.opacity(0.2))
                .padding(.bottom, 2)
            
            Text(getTopAccordsText())
                .font(.system(.caption))
                .foregroundColor(.primary)
                .lineLimit(1)
            
            VStack(alignment: .leading, spacing: 6) {
                // Time pill
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(.caption2))
                        .foregroundColor(Color.blue)
                    Text(getTimeTag())
                        .font(.system(.caption2, weight: .medium))
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Capsule().fill(Color(hex: "D7E8FA")))
                
                // Occasion pill
                HStack(spacing: 4) {
                    Image(systemName: "briefcase")
                        .font(.system(.caption2))
                        .foregroundColor(Color.orange)
                    Text(getOccasionTag())
                        .font(.system(.caption2, weight: .medium))
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Capsule().fill(Color(hex: "F1DAB7")))
            }
        }
        .padding(Constants.UI.defaultPadding)
        .background(
            RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                .fill(Color(UIColor { tc in tc.userInterfaceStyle == .dark ? UIColor(hex: "2C2C2E") : UIColor.white }))
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
        .frame(width: 162)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(data.name) by \(data.brand), \(getTopAccordsText()), \(getTimeTag()), \(getOccasionTag())")
    }
    
    private func getTopAccordsText() -> String {
        let sorted = data.mainAccords.sorted { $0.value > $1.value }
        let top2 = sorted.prefix(2).map { $0.key.capitalized }
        return top2.map { "• \($0)" }.joined(separator: " ")
    }
    
    private func getTimeTag() -> String {
        let hasDay = data.tags.contains("Day")
        let hasNight = data.tags.contains("Night")
        if hasDay && hasNight { return "Day & Night" }
        if hasDay { return "Day" }
        if hasNight { return "Night" }
        return "Day & Night"
    }
    
    private func getOccasionTag() -> String {
        let occasions = ["Formal", "Casual", "Informal"]
        return data.tags.first(where: { occasions.contains($0) }) ?? "Casual"
    }
}

#Preview {
    let mockPerfume = Perfume(name: "MYSLF Eau de Parfum", brand: "Yves Saint Laurent", topNotes: ["calabrian bergamot", "bergamot"], middleNotes: ["tunisian orange blossom"], baseNotes: ["ambrofix", "patchouli"], mainAccords: ["Citrus": 1.0, "White Floral": 0.83], imageName: "yslMyslf", tags: ["Moderate", "Day", "Formal"], mlIdentifier: "ysl myslf")
    
    return ScrollView(.horizontal) {
        HStack(spacing: 16) {
            PerfumeCard(data: mockPerfume)
            PerfumeCard(data: mockPerfume, showStar: true)
        }
        .padding()
        .background(Color(hex: "FDFCF9")) // AppBackground
    }
}
