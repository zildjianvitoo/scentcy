//
//  HomeView.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 05/06/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var allPerfumes: [Perfume]
    @State private var viewModel = HomeViewModel()
    
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

                        if let sniffed = viewModel.previouslySniffed {
                            Button {
                                selectedPerfume = sniffed
                            } label: {
                                PreviouslySniffedCard(data: sniffed)
                            }
                            .buttonStyle(PlainButtonStyle())
                        } else {
                            Text("No perfumes sniffed yet. Scan one to see it here!")
                                .font(Typography.notes)
                                .foregroundColor(.secondary)
                        }
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
                                ForEach(viewModel.recommendedPerfumes) { perfume in
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
        .onAppear {
            viewModel.update(with: allPerfumes)
        }
        .onChange(of: allPerfumes) {
            viewModel.update(with: allPerfumes)
        }
        .sheet(item: $selectedPerfume) { perfume in
            PerfumeDetailView(perfume: perfume)
        }
    }
}

#Preview {
    HomeView()
}
