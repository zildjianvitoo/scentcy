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
    
    @State private var selectedTab: JourneyTab = .sniffed
    @State private var selectedPerfume: Perfume?

    var currentList: [Perfume] {
        selectedTab == .sniffed ? viewModel.sniffedPerfumes : viewModel.savedPerfumes
    }

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {

                Text("Scent Journey")
                    .font(Typography.display)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                SegmentedControl(selected: $selectedTab)
                    .padding(.horizontal, 20)

                if currentList.isEmpty {
                    Spacer()
                    JourneyEmpty(tab: selectedTab)
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 24) {
                            ForEach(currentList) { perfume in
                                Button {
                                    selectedPerfume = perfume
                                } label: {
                                    PerfumeCard(data: perfume, showStar: selectedTab == .saved)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                    }
                }
            }
            .onAppear {
                viewModel.update(with: allPerfumes)
            }
            .onChange(of: allPerfumes) {
                viewModel.update(with: allPerfumes)
            }
        }
        .sheet(item: $selectedPerfume) { perfume in
            PerfumeDetailView(perfume: perfume)
        }
    }
}

#Preview {
    JourneyView()
}
