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
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
                        .frame(width: 150, height: 180)

                    Image(data.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 150)
                }
                
                if showStar {
                    Image(systemName: "star.fill")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.88, green: 0.78, blue: 0.60)) // Gold color
                        .frame(width: 28, height: 28)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                        .padding(12)
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(data.name)
                    .font(Typography.bodyStrong)
                    .lineLimit(1)
                    .foregroundColor(.primary)

                Text(data.brand)
                    .font(Typography.body)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
            .frame(width: 150, alignment: .leading)
        }
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
    }
}
