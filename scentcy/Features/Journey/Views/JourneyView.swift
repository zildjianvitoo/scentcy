//
//  JourneyView.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI
import SwiftData

struct JourneyView: View {
    @Query private var allPerfumes: [Perfume]
    @State private var viewModel = JourneyViewModel()
    
    @State private var selectedTab: JourneyTab = .history
    @State private var selectedPerfume: Perfume?

    var currentList: [Perfume] {
        selectedTab == .history ? viewModel.sniffedPerfumes : viewModel.savedPerfumes
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header
            HStack {
                Text("Scent Journey")
                    .font(Typography.screenTitle)
                    .foregroundStyle(Color.primary)
                Spacer()
            }
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.top, Constants.UI.defaultPadding)

            SegmentedControl(selected: $selectedTab)
                .padding(.horizontal, Constants.UI.screenPadding)

            if currentList.isEmpty {
                Spacer()
                let emptyModel = JourneyEmptyModel(tab: selectedTab)
                EmptyStateView(
                    imageName: emptyModel.imageName,
                    title: emptyModel.title,
                    subtitle: emptyModel.subtitle
                )
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(currentList) { perfume in
                            Button {
                                selectedPerfume = perfume
                            } label: {
                                PerfumeListCard(data: perfume, showStar: selectedTab == .saved)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, Constants.UI.screenPadding)
                    .padding(.bottom, 100)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Scent Journey")
        .onAppear {
            viewModel.update(with: allPerfumes)
        }
        .onChange(of: allPerfumes) {
            viewModel.update(with: allPerfumes)
        }
        .sheet(item: $selectedPerfume, onDismiss: {
            viewModel.update(with: allPerfumes)
        }) { perfume in
            PerfumeDetailView(perfume: perfume)
        }
    }
}

#Preview {
    JourneyView()
}
