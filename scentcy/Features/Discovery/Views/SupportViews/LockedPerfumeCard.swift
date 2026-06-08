//
//  LockedPerfumeCard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import SwiftUI

struct LockedPerfumeCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.appSecondary.opacity(0.5))
                    .frame(width: 120, height: 140)

                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.7))
                        .frame(width: 32, height: 32)
                    Image(systemName: "lock")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.primary.opacity(0.35))
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.primary.opacity(0.1))
                    .frame(width: 80, height: 10)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.primary.opacity(0.07))
                    .frame(width: 55, height: 8)
            }
            .padding(.horizontal, 2)
        }
        .frame(width: 120)
    }
}

#Preview {
    LockedPerfumeCard()
}
