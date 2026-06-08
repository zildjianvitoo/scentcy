//
//  TagChip.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import SwiftUI

struct TagChip: View {
    let label: String

    var tagColor: Color {
        switch label.lowercased() {
        case "night":  return Color.appPrimary
        case "formal": return Color.appSecondary
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
    HStack {
        TagChip(label: "Night")
        TagChip(label: "Formal")
    }
    .padding()
}
