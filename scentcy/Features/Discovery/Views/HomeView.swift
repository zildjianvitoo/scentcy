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

                    // MARK: - Header
                    Text("Discover")
                        .font(Typography.display)
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                    // MARK: - Your Perfume Vibe
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Perfume Vibe")
                            .font(Typography.metric)
                            .padding(.horizontal, 20)

                        Text("Built from perfumes you snaped")
                            .font(Typography.detailPerfume)
                            .foregroundStyle(Color.textGray)
                            .padding(.horizontal, 20)

                        VibeCard()
                            .padding(.horizontal, 20)
                    }

                    // MARK: - Perfumes Recommendation
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 0) {
                            NavigationLink(destination: PerfumeRecommendationView()) {
                                HStack(alignment: .firstTextBaseline, spacing: 8) {
                                    Text("Perfumes Recommendation")
                                        .font(Typography.metric)
                                        .foregroundStyle(Color.primary)

                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundStyle(Color.textGray)
                                }
                            }

                            Text("Based on your Woody vibe")
                                .font(Typography.body)
                                .foregroundStyle(Color.textGray)
                        }
                        .padding(.horizontal, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(perfumeDataArray.prefix(5)) { perfume in
                                    Button {
                                        selectedPerfume = perfume
                                    } label: {
                                        PerfumeCard(data: perfume)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4)
                        }
                    }

                    Spacer(minLength: 100)
                }
            }
        }
        .sheet(item: $selectedPerfume) { perfume in
            PerfumeDetailView(icon: perfume.name, productName: perfume.name, brand: perfume.brand)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
