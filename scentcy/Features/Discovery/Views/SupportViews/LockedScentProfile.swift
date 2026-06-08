//
//  LockedScentProfile.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import SwiftUI

struct LockedScentProfile: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            ZStack {
                VStack(alignment: .leading, spacing: 6) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.primary.opacity(0.15))
                        .frame(width: 140, height: 10)

                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.primary.opacity(0.1))
                        .frame(width: 90, height: 8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)

                Color.appSecondary.opacity(0.25)
                    .blur(radius: 3)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .background(Color.appSecondary.opacity(0.6))

            Rectangle()
                .fill(Color.primary.opacity(0.06))
                .frame(height: 1)

            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.appSecondary)
                        .frame(width: 36, height: 36)
                    Image(systemName: "arrow.right")
                        .foregroundStyle(Color.primary)
                        .font(.system(size: 13, weight: .semibold))
                }

                Text("Swipe to reveal")
                    .font(Typography.bodyStrong)
                    .foregroundStyle(Color.primary)

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.07), radius: 10, x: 0, y: 3)
    }
}

#Preview {
    LockedScentProfile()
        .padding()
}
