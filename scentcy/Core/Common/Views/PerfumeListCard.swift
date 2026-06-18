//
//  PerfumeListCard.swift
//  scentcy
//

import SwiftUI

struct PerfumeListCard: View {
    let data: Perfume
    var showStar: Bool = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(spacing: 16) {
                // Image
                Image(data.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .padding(8)
                    .background(Color.appCardBackground)
                    .cornerRadius(16)
                
                // Text Details
                VStack(alignment: .leading, spacing: 4) {
                    Text(data.name)
                        .font(Typography.bodyStrong)
                        .foregroundColor(.primary)
                    
                    Text(data.brand)
                        .font(Typography.body)
                        .foregroundColor(.textGray)
                    
                    Divider()
                        .padding(.vertical, 4)
                    
                    // Scent Notes
                    let sorted = data.mainAccords.sorted { $0.value > $1.value }
                    let topAccords = sorted.prefix(2).map { "• \($0.key.capitalized)" }.joined(separator: " ")
                    Text(topAccords)
                        .font(Typography.label)
                        .fontWeight(.regular)
                        .foregroundColor(.primary)
                    
                    // Tags
                    HStack(spacing: 8) {
                        let hasDay = data.tags.contains("Day")
                        let hasNight = data.tags.contains("Night")
                        let timeTag = (hasDay && hasNight) ? "Day & Night" : (hasDay ? "Day" : (hasNight ? "Night" : ""))
                        
                        if !timeTag.isEmpty {
                            HStack(spacing: 4) {
                                Image(systemName: "clock")
                                    .font(.system(.caption2))
                                    .foregroundColor(Color(hex: "0080FF"))
                                Text(timeTag)
                                    .font(Typography.label)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color(hex: "CEE4F6"))
                            .cornerRadius(10)
                        }
                        
                        let hasFormal = data.tags.contains("Formal")
                        let hasCasual = data.tags.contains("Casual")
                        let occasionTag = (hasFormal && hasCasual) ? "Formal & Casual" : (hasFormal ? "Formal" : (hasCasual ? "Casual" : ""))
                        
                        if !occasionTag.isEmpty {
                            HStack(spacing: 4) {
                                Image(systemName: "suitcase")
                                    .font(.system(.caption2))
                                    .foregroundColor(Color(hex: "E77D0C"))
                                Text(occasionTag)
                                    .font(Typography.label)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color(hex: "F0D9BA"))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.top, 4)
                }
                
                Spacer()
            }
            .padding(Constants.UI.defaultPadding)
            .background(
                RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                    .fill(Color(hex: "FEFCFB"))
            )
            .shadow(color: Color.primary.opacity(0.05), radius: 8, x: 0, y: 4)
            
            // Star Icon
            if showStar {
                Image(systemName: "star.fill")
                    .font(.system(.footnote))
                    .foregroundColor(Color(hex: "E1B376"))
                    .frame(width: 28, height: 28)
                    .background(Color.appCardBackground)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                    .padding(12) // padding from the top-right corner of the card
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(data.name) by \(data.brand)")
    }
}


#Preview {
    let mockPerfume = Perfume(name: "MYSLF Eau de Parfum", brand: "Yves Saint Laurent", topNotes: ["calabrian bergamot", "bergamot"], middleNotes: ["tunisian orange blossom"], baseNotes: ["ambrofix", "patchouli"], mainAccords: ["Citrus": 1.0, "White Floral": 0.83], imageName: "yslMyslf", tags: ["Moderate", "Day", "Formal"], mlIdentifier: "ysl myslf")
    
    return VStack(spacing: 12) {
        PerfumeListCard(data: mockPerfume, showStar: false)
        PerfumeListCard(data: mockPerfume, showStar: true)
    }
    .padding()
    .background(Color.appBackground)
}
