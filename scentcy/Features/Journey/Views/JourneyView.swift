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
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.appBackground.ignoresSafeArea())
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
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("SwitchToJourneySaved"))) { _ in
            selectedTab = .saved
        }
    }
}

#Preview {
    JourneyView()
}
