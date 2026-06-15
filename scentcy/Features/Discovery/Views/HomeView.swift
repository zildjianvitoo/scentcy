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

                    // MARK: - Header
                    Text("Discover")
                        .font(Typography.display)
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

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
                            .padding(.vertical, 4)
                        }
                    }

                    Spacer(minLength: 100)
                }
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


#Preview {
    NavigationStack {
        HomeView()
    }
}
