//
//  ManualInputSheet.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 12/06/26.
//

import SwiftUI

struct ManualInputSheet: View {
    @Binding var isPresented: Bool
    @Binding var currentDetent: PresentationDetent
    var allPerfumes: [Perfume]
    var onSelectPerfume: (String, String) -> Void

    @State private var searchText = ""
    @State private var selectedPerfume: String? = nil
    @FocusState private var isSearchFocused: Bool

    private var searchResults: [Perfume] {
        guard searchText.count >= 3 else { return [] }
        let query = searchText.lowercased()
        return allPerfumes
            .filter { $0.name.lowercased().contains(query) || $0.brand.lowercased().contains(query) }
    }

    private var showResults: Bool { searchText.count >= 3 }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            ZStack {
                Text("Input Perfume")
                    .font(Typography.bodyStrong)
                    .foregroundColor(.primary)

                HStack {
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark")
                            .font(.system(.caption, weight: .bold))
                            .foregroundColor(.primary)
                            .frame(width: 32, height: 32)
                    }
                    .background(.regularMaterial, in: Circle())
                    Spacer()
                }
            }
            .padding(.horizontal, Constants.UI.largePadding)
            .padding(.top, Constants.UI.screenPadding)
            .padding(.bottom, Constants.UI.screenPadding)

            if showResults {
                // Results state
                VStack(spacing: 0) {
                    Text("Choose which perfume you mean?")
                        .font(Typography.body)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, Constants.UI.largePadding)
                        .padding(.bottom, 12)

                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 10) {
                            ForEach(searchResults, id: \.name) { perfume in
                                PerfumeRadioRow(
                                    perfumeName: perfume.name,
                                    brandName: perfume.brand,
                                    imageName: perfume.imageName,
                                    isSelected: selectedPerfume == perfume.name,
                                    onTap: { selectedPerfume = perfume.name }
                                )
                            }
                        }
                        .padding(.horizontal, Constants.UI.largePadding)
                    }

                    // Done Button Only
                    Button(action: {
                        if let selected = selectedPerfume,
                           let perfume = searchResults.first(where: { $0.name == selected }) {
                            onSelectPerfume(perfume.name, perfume.brand)
                            isPresented = false
                        }
                    }) {
                        Text("Select")
                            .font(Typography.bodyStrong)
                            .foregroundColor(selectedPerfume != nil ? .black : .black.opacity(0.3))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, Constants.UI.defaultPadding)
                    }
                    .background(
                        Capsule()
                            .fill(selectedPerfume != nil ? Color.appButton : Color.appGray.opacity(0.3))
                    )
                    .background(.regularMaterial, in: Capsule())
                    .disabled(selectedPerfume == nil)
                    .padding(.horizontal, Constants.UI.largePadding)
                    .padding(.bottom, Constants.UI.defaultPadding)
                    .padding(.top, 12)
                }
                .transition(.opacity.combined(with: .move(edge: .bottom)))

            } else if currentDetent == .large {
                // Empty state
                VStack(spacing: -16) {
                    Spacer(minLength: 16)

                    Image("manualInputEmpty")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)

                    Text("Which perfume are you into?")
                        .font(Typography.body)

                    Spacer()
                }
                .transition(.opacity)
            } else {
                Spacer()
            }

            // Search field (Always at the bottom)
            HStack(spacing: 12) {
                TextField("e.g. Sauvage by Dior", text: $searchText)
                    .font(Typography.body)
                    .focused($isSearchFocused)
                    .onChange(of: isSearchFocused) {
                        if isSearchFocused {
                            currentDetent = .large
                        }
                    }

                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(.body))
                            .foregroundColor(.gray.opacity(0.8))
                    }
                }
            }
            .padding(.horizontal, Constants.UI.defaultPadding)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.appGray.opacity(0.3))
            )
            .padding(.horizontal, Constants.UI.largePadding)
            .padding(.bottom, Constants.UI.defaultPadding)
        }
        .animation(.easeInOut(duration: 0.25), value: showResults)
        .background(Color.appBackground)
        .onAppear {
            // ONLY focus if the sheet is opened in large detent, otherwise don't focus yet!
            if currentDetent == .large {
                isSearchFocused = true
            }
        }
    }
}

#Preview {
    ManualInputSheet(isPresented: .constant(true), currentDetent: .constant(.large), allPerfumes: [], onSelectPerfume: { _, _ in })
}

