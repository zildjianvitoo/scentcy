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
            // Header
            HStack {
                Text("Discover")
                    .font(Typography.screenTitle)
                    .foregroundStyle(Color.primary)
                Spacer()
            }
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.top, Constants.UI.defaultPadding)
            .padding(.bottom, 16)

            if viewModel.previouslySniffed == nil {
                Spacer()
                EmptyStateView(
                    imageName: "discoverEmpty",
                    title: "Find your next favourite bottle",
                    subtitle: "Snap a **perfume you love** and\nwe'll find your next obsession",
                    buttonTitle: "Take picture",
                    buttonAction: { isShowingCamera = true }
                )
                Spacer()
                Spacer()
            } else {
                VStack(alignment: .leading, spacing: 24) {

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
                        .padding(.horizontal, Constants.UI.screenPadding)

                        VibeCard(
                            vibeName: viewModel.vibeName,
                            vibeIcon: viewModel.vibeIcon,
                            aromaNotes: viewModel.aromaNotes
                        )
                            .padding(.horizontal, Constants.UI.screenPadding)
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
                        .padding(.horizontal, Constants.UI.screenPadding)

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
                            .padding(.horizontal, Constants.UI.screenPadding)
                            .padding(.vertical, 4)
                        }
                    }

                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Discover")
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
