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
    @State private var showAddPerfumeToast = false
    @State private var addedPerfumeName = ""

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.previouslySniffed == nil {
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
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        // Header
                        HStack {
                            Text("Discover")
                                .font(Typography.screenTitle)
                                .foregroundStyle(Color.primary)
                            Spacer()
                        }
                        .padding(.horizontal, Constants.UI.screenPadding)
                        .padding(.top, Constants.UI.defaultPadding)
                        .padding(.bottom, -16)

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
                                HStack(alignment: .center) {
                                    Text("Perfumes Recommendation")
                                        .font(Typography.metric)
                                        .foregroundStyle(Color.primary)
                                    Spacer()
                                    HStack {
                                        Text("See All")
                                            .font(Typography.label)
                                            .foregroundStyle(Color.textGray)
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundStyle(Color.textGray)
                                    }
                                }
                            }

                            Text("Based on your \(viewModel.vibeName) vibe")
                                .font(Typography.body)
                                .foregroundStyle(Color.textGray)
                        }
                        .padding(.horizontal, Constants.UI.screenPadding)

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
                            .scrollTargetLayout()
                            .padding(.vertical, 4)
                        }
                        .contentMargins(.horizontal, Constants.UI.screenPadding, for: .scrollContent)
                        .scrollTargetBehavior(.viewAligned)
                        }
                    }
                    .padding(.bottom, 120) // Add clearance for the floating tab bar
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("")
        .toolbar(.hidden, for: .navigationBar)
        .overlay(alignment: .top) {
            if showAddPerfumeToast {
                ToastNotificationAddPerfume(showToast: $showAddPerfumeToast, perfumeName: addedPerfumeName)
                    .padding(.top, 16)
            }
        }
        .onAppear {
            viewModel.update(with: allPerfumes)
        }
        .onChange(of: allPerfumes) { oldValue, newValue in
            viewModel.update(with: newValue)
        }
        .sheet(item: $selectedPerfume) { perfume in
            PerfumeDetailView(perfume: perfume)
        }
        .fullScreenCover(isPresented: $isShowingCamera, onDismiss: {
            viewModel.update(with: allPerfumes)
        }) {
            CameraView()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("ShowAddPerfumeToast"))) { notification in
            if let name = notification.object as? String {
                addedPerfumeName = name
                withAnimation { showAddPerfumeToast = true }
                
                // Auto hide after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    if showAddPerfumeToast {
                        withAnimation { showAddPerfumeToast = false }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
