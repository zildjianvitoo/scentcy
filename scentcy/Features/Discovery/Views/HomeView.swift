//
//  HomeView.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 05/06/26.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Query private var allPerfumes: [Perfume]
    @State private var viewModel = HomeViewModel()

    @State private var selectedPerfume: Perfume?
    @State private var isShowingCamera = false

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.previouslySniffed == nil {
                DiscoverEmpty(onTakePicture: {
                    isShowingCamera = true
                })
            } else {
                VStack(alignment: .leading, spacing: 24) {

                    // MARK: - Header
                    Text("Discover")
                        .font(Typography.display)
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                    // Removed Previously Sniffed section

                    // MARK: - Similar Perfumes
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Your Perfume Vibe")
                                .font(Typography.metric)
                                .foregroundStyle(Color.primary) 

                            Text("Built from perfumes you snaped")
                                .font(Typography.detailPerfume)
                                .foregroundStyle(Color.textGray)
                        }
                        .padding(.horizontal, 20)

                        VibeCard(
                            vibeName: viewModel.vibeName,
                            vibeIcon: viewModel.vibeIcon,
                            aromaNotes: viewModel.aromaNotes
                        )
                            .padding(.horizontal, 20)
                    }

                    // MARK: - Perfumes Recommendation
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 0) {
                            NavigationLink(
                                destination: PerfumeRecommendationView()
                            ) {
                                HStack(
                                    alignment: .center,
                                    spacing: 8
                                ) {
                                    Text("Perfumes Recommendation")
                                        .font(Typography.metric)
                                        .foregroundStyle(Color.primary)

                                    Image(systemName: "chevron.right")
                                        .font(
                                            .system(
                                                size: 12,
                                                weight: .semibold
                                            )
                                        )
                                        .foregroundStyle(Color.textGray)
                                }
                            }

                            Text("Based on your \(viewModel.vibeName) vibe")
                                .font(Typography.body)
                                .foregroundStyle(Color.textGray)
                        }
                        .padding(.horizontal, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.recommendedPerfumes) {
                                    perfume in
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

                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground.ignoresSafeArea())
        .onAppear {
            viewModel.update(with: allPerfumes)
        }
        .onChange(of: allPerfumes) {
            viewModel.update(with: allPerfumes)
        }
        .sheet(item: $selectedPerfume) { perfume in
            PerfumeDetailView(perfume: perfume)
        }
        .fullScreenCover(isPresented: $isShowingCamera) {
            CameraView()
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
