//
//  Perfumecard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI

struct PerfumeCardData: Identifiable {
    let id = UUID()
    let name: String
    let brand: String
    let imageName: String
}

// Dummy data
let dummyPerfumes: [PerfumeCardData] = [
    PerfumeCardData(name: "Eau Capitale", brand: "Diptyque",          imageName: "eaucapitale"),
    PerfumeCardData(name: "Libre",        brand: "Yves Saint Laurent", imageName: "libre"),
    PerfumeCardData(name: "Rose",         brand: "La Labo",            imageName: "rose"),
    PerfumeCardData(name: "Baccarat 540", brand: "Maison Margiela",    imageName: "baccarat"),
]

struct PerfumeCard: View {
    let data: PerfumeCardData

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Image container
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(hex: "F7F3EE"))
                    .frame(width: 150, height: 180)

                Image(data.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 150)
            }

            // Text
            VStack(alignment: .leading, spacing: 2) {
                Text(data.name)
                    .font(Typography.bodyStrong)
                    .foregroundStyle(Color.appPrimary)
                    .lineLimit(1)

                Text(data.brand)
                    .font(Typography.notes)
                    .foregroundStyle(Color.textGray)
                    .lineLimit(1)
            }
            .frame(width: 150, alignment: .leading)
        }
    }
}

// MARK: - Usage di HomeView (ganti comment ScrollView)
// ScrollView(.horizontal, showsIndicators: false) {
//     HStack(spacing: 16) {
//         ForEach(dummyPerfumes) { perfume in
//             PerfumeCard(data: perfume)
//         }
//     }
//     .padding(.horizontal, 20)
//     .padding(.top, 8)
// }

#Preview {
    ScrollView(.horizontal) {
        HStack(spacing: 16) {
            ForEach(dummyPerfumes) { perfume in
                PerfumeCard(data: perfume)
            }
        }
        .padding()
    }
}
