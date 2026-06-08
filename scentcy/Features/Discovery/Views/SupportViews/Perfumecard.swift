//
//  Perfumecard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI

struct PerfumeCard: View {
    let data: Perfume

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.appCardBackground)
                    .frame(width: 150, height: 180)

                Image(data.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 150)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(data.name)
                    .font(Typography.bodyStrong)
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
