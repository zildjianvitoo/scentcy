//
//  JourneyView.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI
import SwiftData

struct JourneyView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allPerfumes: [Perfume]
    @State private var viewModel = JourneyViewModel()
    
    @State private var selectedTab: JourneyTab = .history
    @State private var selectedPerfume: Perfume?

    var currentList: [Perfume] {
        selectedTab == .history ? viewModel.sniffedPerfumes : viewModel.savedPerfumes
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {


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
                List {
                    ForEach(currentList) { perfume in
                        Button {
                            selectedPerfume = perfume
                        } label: {
                            PerfumeListCard(data: perfume, showStar: selectedTab == .saved)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            if selectedTab == .history {
                                Button(role: .destructive) {
                                    deleteHistory(perfume)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.red)
                            } else if selectedTab == .saved {
                                Button(role: .destructive) {
                                    deleteSaved(perfume)
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                        }
                    }
                    Color.clear
                        .frame(height: 100)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .padding(.top, -8) // slight adjustment for List default padding
            }
        }
        .padding(.top, -20)
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
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("SwitchToJourneySaved"))) { _ in
            selectedTab = .saved
        }
    }

    private func deleteHistory(_ perfume: Perfume) {
        if let found = allPerfumes.first(where: { $0.id == perfume.id }) {
            found.isScanned = false
            found.scannedAt = nil
            try? modelContext.save()
            viewModel.update(with: allPerfumes)
        }
    }

    private func deleteSaved(_ perfume: Perfume) {
        if let found = allPerfumes.first(where: { $0.id == perfume.id }) {
            found.isFavorite = false
            try? modelContext.save()
            viewModel.update(with: allPerfumes)
        }
    }
}

#Preview {
    JourneyView()
}
