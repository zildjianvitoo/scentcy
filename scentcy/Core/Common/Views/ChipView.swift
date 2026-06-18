//
//  ChipView.swift
//  scentcy
//
//  Created by Antigravity
//

import SwiftUI

enum ChipStyle {
    case note
    case tag
}

struct ChipView: View {
    let label: String
    let style: ChipStyle
    
    var tagColor: Color {
        switch label.lowercased() {
        case "night":  return Color.appSecondary
        case "formal": return Color.appPrimary
        case "day":    return Color.appPrimary
        case "casual": return Color.appSecondary
        default:       return Color.appSecondary
        }
    }

    var body: some View {
        switch style {
        case .note:
            HStack(spacing: 4) {
                Circle()
                    .fill(Color.appPrimary)
                    .frame(width: 5, height: 5)

                Text(label)
                    .font(Typography.scentNotes)
                    .foregroundStyle(Color.primary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(Color.white.opacity(0.7))
                    .overlay(
                        Capsule()
                            .strokeBorder(Color.primary.opacity(0.1), lineWidth: 1)
                    )
            )
        case .tag:
            Text(label)
                .font(.system(.footnote, weight: .regular))
                .foregroundStyle(Color.primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .background(tagColor)
                .clipShape(Capsule())
        }
    }
}

#Preview {
    HStack {
        ChipView(label: "Amber", style: .note)
        ChipView(label: "Night", style: .tag)
        ChipView(label: "Formal", style: .tag)
    }
    .padding()
}
