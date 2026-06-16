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
                        .fill(Color(hex: "F8F7F4"))
                        .frame(width: 140, height: 150)

                    Image(data.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 130)
                }
                
                if showStar {
                    Image(systemName: "star.fill")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.88, green: 0.78, blue: 0.60)) // Gold color
                        .frame(width: 28, height: 28)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                        .padding(8)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(data.name)
                    .font(Typography.bodyStrong)
                    .foregroundColor(.black)
                    .lineLimit(1)

                Text(data.brand)
                    .font(Typography.body)
                    .foregroundColor(.black)
                    .lineLimit(1)
            }
            
            Divider()
                .background(Color.gray.opacity(0.2))
                .padding(.bottom, 2)
            
            Text(getTopAccordsText())
                .font(.system(size: 12))
                .foregroundColor(.black)
                .lineLimit(1)
            
            VStack(alignment: .leading, spacing: 6) {
                // Time pill
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 10))
                        .foregroundColor(Color.blue)
                    Text(getTimeTag())
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Capsule().fill(Color(hex: "D7E8FA")))
                
                // Occasion pill
                HStack(spacing: 4) {
                    Image(systemName: "briefcase")
                        .font(.system(size: 10))
                        .foregroundColor(Color.orange)
                    Text(getOccasionTag())
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Capsule().fill(Color(hex: "F1DAB7")))
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
        .frame(width: 172)
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
    ScrollView(.horizontal) {
        HStack(spacing: 16) {
            ForEach(perfumeDataArray.prefix(4)) { perfume in
                PerfumeCard(data: perfume)
            }
        }
        .padding()
        .background(Color(hex: "FDFCF9")) // AppBackground
    }
}
