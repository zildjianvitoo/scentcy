//
//  PerfumeDetailView.swift
//  scentcy
//
//  Created by Afra on 06/06/26.
//

import SwiftUI
import SwiftData

struct PerfumeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isSaved = false
    @State private var selectedGlossaryType: GlossaryType?
    @State private var showFavoriteToast = false

    @State private var viewModel: PerfumeDetailViewModel

    init(perfume: Perfume) {
        self._viewModel = State(initialValue: PerfumeDetailViewModel(perfume: perfume))
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.appBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    // Hero image with gradient
                    ZStack {
                        LinearGradient(
                            colors: [
                                Color(hex: "F5E6D1"),
                                Color(hex: "F4E2CA"),
                                Color(hex: "FEFCFB")
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                            .frame(height: 260)

                        Image(viewModel.perfume.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .padding(.top, Constants.UI.screenPadding)
                    }

                    // Title + notes
                    VStack(spacing: 4) {
                        Text(viewModel.perfume.name)
                            .font(Typography.bodyStrong)
                            .foregroundColor(.primary)

                        Text(viewModel.perfume.brand)
                            .font(Typography.body)
                            .foregroundColor(.primary)

                        HStack(spacing: 8) {
                            ForEach(viewModel.scentNotes, id: \.self) { note in
                                Text("•\(note)")
                                    .font(Typography.scentNotes)
                                    .foregroundColor(.primary)
                            }
                        }
                        .padding(.top, 4)
                    }
                    .padding(.top, 8)
                    .padding(.bottom, Constants.UI.largePadding)

                    VStack(alignment: .leading, spacing: 24) {
                        // Performance
                        DetailSectionCard(title: "Performance", onTap: { selectedGlossaryType = .performance }) {
                            MetricPairCard(
                                leftIcon: "hourglass",
                                leftLabel: "Longevity",
                                leftValue: viewModel.longevity,
                                rightIcon: "wave.3.right",
                                rightLabel: "Sillage",
                                rightValue: viewModel.sillage
                            )
                        }

                        // Usage
                        DetailSectionCard(title: "Usage", onTap: { selectedGlossaryType = .usage }) {
                            MetricPairCard(
                                leftIcon: "clock",
                                leftLabel: "Time",
                                leftValue: viewModel.time,
                                rightIcon: "suitcase",
                                rightLabel: "Occasion",
                                rightValue: viewModel.occasion
                            )
                        }

                        // Notes
                        DetailSectionCard(title: "Notes", onTap: { selectedGlossaryType = .notes }) {
                            NotesCard(notes: viewModel.notes)
                        }
                    }
                    .padding(.horizontal, Constants.UI.largePadding)
                    .padding(.bottom, 40)
                }
            }
            .ignoresSafeArea(edges: .top)

            // Floating buttons
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(.footnote, weight: .bold))
                        .foregroundColor(.primary)
                        .frame(width: 40, height: 40)
                }
                .background(.regularMaterial, in: Circle())

                Spacer()

                Button(action: {
                    viewModel.toggleFavorite()
                    if viewModel.isFavorite {
                        withAnimation { showFavoriteToast = true }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation { showFavoriteToast = false }
                        }
                    } else {
                        withAnimation { showFavoriteToast = false }
                    }
                }) {
                    Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                        .font(.system(.callout, weight: .semibold))
                        .foregroundColor(viewModel.isFavorite ? Color.appButton : .black)
                        .frame(width: 40, height: 40)
                }
                .background(.regularMaterial, in: Circle())
            }
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.top, Constants.UI.largePadding)
            
            if showFavoriteToast {
                ToastNotification(showFavoriteToast: $showFavoriteToast)
            }
        }
        .sheet(item: $selectedGlossaryType) { type in
            FragranceGlossarySheet(type: type)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Perfume.self, configurations: config)
    let mockPerfume = Perfume(name: "GoodGirl", brand: "Carolina Herrera", imageName: "goodgirl1")
    
    return PerfumeDetailView(perfume: mockPerfume)
        .modelContainer(container)
}
