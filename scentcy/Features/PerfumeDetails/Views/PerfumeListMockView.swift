//
//  PerfumeListMockView.swift
//  scentcy
//
//  Created by Afra on 07/06/26.
//

import SwiftUI

struct PerfumeListMockView: View {
    @State private var selectedPerfume: PerfumeDataModel?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(perfumeDataArray) { perfume in
                    ProductCardGrid(
                        name: perfume.perfumeName,
                        icon: perfume.perfumeName,
                        brand: perfume.brand
                    )
                    .onTapGesture {
                        selectedPerfume = perfume
                    }
                }
            }
            .padding(.horizontal)
        }
        .sheet(item: $selectedPerfume) { perfume in
            PerfumeDetailView(icon: perfume.perfumeName, productName: perfume.perfumeName, brand: perfume.brand)
        }
    }
}


#Preview {
    PerfumeListMockView()
}
