//
//  HomeView.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 05/06/26.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedPerfume: Perfume?
    
    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {

                    // MARK: - Previously Sniffed
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Previously Sniffed")
                            .font(Typography.bodyStrong)

                        Button {
                            selectedPerfume = perfumeDataArray[26]
                        } label: {
                            PreviouslySniffedCard(data: perfumeDataArray[26])
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 20)

                    // MARK: - Similar Perfumes
                    VStack(alignment: .leading, spacing: 8) {
                        NavigationLink(destination: PerfumeRecommendationView()) {
                            HStack(alignment: .center, spacing: 4) {
                                Text("Similar Perfumes")
                                    .font(Typography.display)
                                    .foregroundStyle(Color.primary)

                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color.textGray)
                            }
                            .padding(.horizontal, 20)
                        }

                        Text("Curated based on your liked perfumes")
                            .font(Typography.notes)
                            .foregroundStyle(Color.textGray)
                            .padding(.horizontal, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(perfumeDataArray.prefix(4)) { perfume in
                                    Button {
                                        selectedPerfume = perfume
                                    } label: {
                                        PerfumeCard(data: perfume)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    // MARK: - Scent Profile
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your Scent Profile")
                            .font(Typography.display)

                        Text("Based on your sniffing journey")
                            .font(Typography.notes)
                            .foregroundStyle(Color.textGray)

                        ScentProfileCard()
                            .padding(.top, 8)
                    }
                    .padding(.horizontal, 20)

                    Spacer(minLength: 100)
                }
                .padding(.top, 20)
            }

        }
        .sheet(item: $selectedPerfume) { perfume in
            PerfumeDetailView(icon: perfume.name, productName: perfume.name, brand: perfume.brand)
        }
    }
}

#Preview {
    HomeView()
}
