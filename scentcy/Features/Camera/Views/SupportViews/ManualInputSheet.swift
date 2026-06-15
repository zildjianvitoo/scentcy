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
                        Image(systemName: "xmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 32, height: 32)
                    }
                    .glassEffect(.regular.interactive(), in: Circle())
                    Spacer()
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 20)

            if showResults {
                // Results state
                VStack(spacing: 0) {
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
                            .padding(.vertical, 16)
                    }
                    .background(
                        Capsule()
                            .fill(selectedPerfume != nil ? Color.appButton : Color.appGray.opacity(0.3))
                    )
                    .glassEffect(.regular.interactive(), in: Capsule())
                    .disabled(selectedPerfume == nil)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
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
                        .frame(height: 160)

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
                            .font(.system(size: 18))
                            .foregroundColor(.gray.opacity(0.8))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.appGray.opacity(0.3))
            )
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
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
    ManualInputSheet(isPresented: .constant(true), currentDetent: .constant(.large), onSelectPerfume: { _, _ in })
}

