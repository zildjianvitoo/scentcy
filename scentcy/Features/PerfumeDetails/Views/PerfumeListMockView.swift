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
        .sheet(item: $selectedPerfume) { _ in
            TabView(selection: $selectedPerfume) {
                ForEach(perfumeDataArray) { perfume in
                    PerfumeDetailView(icon: perfume.perfumeName, productName: perfume.perfumeName, brand: perfume.brand)
                        .tag(perfume as PerfumeDataModel?)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}


#Preview {
    PerfumeListMockView()
}
