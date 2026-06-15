//
//  ManualInputSheet.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 12/06/26.
//

import SwiftUI

struct ManualInputSheet: View {
    @Binding var isPresented: Bool
    var onSelectPerfume: (String, String) -> Void

    @State private var searchText = ""
    @State private var selectedPerfume: String? = nil
    @FocusState private var isSearchFocused: Bool

    // Mock results — nanti diganti data real
    private var searchResults: [(name: String, brand: String)] {
        guard searchText.count >= 3 else { return [] }
        return [
            ("Shalimar", "Guerlain"),
            ("Shalimar Eau de Parfum", "Guerlain"),
            ("Shalimar Souffle", "Guerlain"),
            ("Shalimar Initial", "Guerlain"),
            ("Shalimar Parfum Initial", "Guerlain"),
        ]
    }

    private var showResults: Bool { searchText.count >= 3 }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            ZStack {
                Text("Input Perfume")
                    .font(Typography.bodyStrong)
                    .foregroundColor(.black)

                HStack {
                    Button(action: { isPresented = false }) {
                        ZStack {
                            Circle()
                                .fill(Color.appGray.opacity(0.4))
                                .frame(width: 32, height: 32)
                            Image(systemName: "xmark")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 20)

            if showResults {
                // Results state
                VStack(spacing: 0) {
                    // Search field
                    HStack(spacing: 12) {
                        TextField("e.g. Sauvage by Dior", text: $searchText)
                            .font(Typography.body)
                            .focused($isSearchFocused)

                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }) {
                                Circle()
                                    .fill(Color.appButton)
                                    .frame(width: 28, height: 28)
                                    .overlay(
                                        Image(systemName: "arrow.up")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(.black)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.appGray.opacity(0.3))
                    )
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)

                    Text("Choose which perfume you mean?")
                        .font(Typography.body)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 12)

                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 10) {
                            ForEach(searchResults, id: \.name) { perfume in
                                PerfumeRadioRow(
                                    perfumeName: perfume.name,
                                    brandName: perfume.brand,
                                    isSelected: selectedPerfume == perfume.name,
                                    onTap: { selectedPerfume = perfume.name }
                                )
                            }
                        }
                        .padding(.horizontal, 24)
                    }

                    Spacer()

                    // Cancel / Done
                    HStack(spacing: 12) {
                        Button(action: {
                            searchText = ""
                            selectedPerfume = nil
                        }) {
                            Text("Cancel")
                                .font(Typography.body)
                                .foregroundColor(.black.opacity(0.5))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(
                                    Capsule()
                                        .fill(Color.appGray.opacity(0.3))
                                )
                        }

                        Button(action: {
                            if let selected = selectedPerfume,
                               let perfume = searchResults.first(where: { $0.name == selected }) {
                                onSelectPerfume(perfume.name, perfume.brand)
                                isPresented = false
                            }
                        }) {
                            Text("Done")
                                .font(Typography.body)
                                .foregroundColor(selectedPerfume != nil ? .black : .black.opacity(0.3))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(
                                    Capsule()
                                        .fill(selectedPerfume != nil ? Color.appButton : Color.appGray.opacity(0.3))
                                )
                        }
                        .disabled(selectedPerfume == nil)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                }
                .transition(.opacity.combined(with: .move(edge: .bottom)))

            } else {
                // Empty state
                VStack(spacing: 24) {
                    Spacer(minLength: 16)

                    Image("manual_input_empty")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)

                    Text("Which perfume are you into?")
                        .font(Typography.body)
                        .foregroundColor(.black.opacity(0.7))

                    // Search field
                    HStack(spacing: 12) {
                        TextField("e.g. Sauvage by Dior", text: $searchText)
                            .font(Typography.body)
                            .focused($isSearchFocused)

                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }) {
                                Circle()
                                    .fill(Color.appButton)
                                    .frame(width: 28, height: 28)
                                    .overlay(
                                        Image(systemName: "arrow.up")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(.black)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.appGray.opacity(0.3))
                    )
                    .padding(.horizontal, 24)

                    Spacer()
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: showResults)
        .background(Color.appBackground)
        .onAppear { isSearchFocused = true }
    }
}

#Preview {
    ManualInputSheet(isPresented: .constant(true), onSelectPerfume: { _, _ in })
}

