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
    @State private var isShowingGlossary = false

    @Bindable var perfume: Perfume

    // Dynamic data
    private var scentNotes: [String] {
        let sorted = perfume.mainAccords.sorted { $0.value > $1.value }
        return sorted.prefix(2).map { $0.key.capitalized }
    }
    
    private var longevity: String {
        let options = ["Eternal", "Long Lasting", "Moderate", "Weak", "Very Weak"]
        return perfume.tags.first(where: { options.contains($0) }) ?? "Moderate"
    }
    
    private var sillage: String {
        let options = ["Intimate", "Moderate", "Strong", "Enormous"]
        // Filter carefully to avoid overlapping names like "Moderate" picking up Longevity's "Moderate"
        // But since both can be Moderate, it's fine. If tags has "Moderate", both can be "Moderate".
        let tag = perfume.tags.last(where: { options.contains($0) }) ?? "Moderate"
        return tag
    }
    
    private var time: String {
        let hasDay = perfume.tags.contains("Day")
        let hasNight = perfume.tags.contains("Night")
        if hasDay && hasNight { return "Day & Night" }
        if hasDay { return "Day" }
        if hasNight { return "Night" }
        return "Day & Night"
    }
    
    private var occasion: String {
        let options = ["Formal", "Casual", "Informal"]
        return perfume.tags.first(where: { options.contains($0) }) ?? "Casual"
    }
    
    private var notes: [String] {
        let allNotes = perfume.topNotes + perfume.middleNotes + perfume.baseNotes
        return allNotes.map { $0.capitalized }
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

                        Image(perfume.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .padding(.top, 20)
                    }

                    // Title + notes
                    VStack(spacing: 4) {
                        Text(perfume.name)
                            .font(Typography.bodyStrong)
                            .foregroundColor(.black)

                        Text(perfume.brand)
                            .font(Typography.body)
                            .foregroundColor(.black)

                        HStack(spacing: 8) {
                            ForEach(scentNotes, id: \.self) { note in
                                Text("•\(note)")
                                    .font(Typography.scentNotes)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.top, 4)
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 24)

                    VStack(alignment: .leading, spacing: 24) {
                        // Performance
                        VStack(alignment: .leading, spacing: 10) {
                            DetailSectionHeader(title: "Performance")

                            MetricPairCard(
                                leftIcon: "hourglass",
                                leftLabel: "Longevity",
                                leftValue: longevity,
                                rightIcon: "wave.3.right",
                                rightLabel: "Sillage",
                                rightValue: sillage
                            )
                        }

                        // Usage
                        VStack(alignment: .leading, spacing: 10) {
                            DetailSectionHeader(title: "Usage")

                            MetricPairCard(
                                leftIcon: "clock",
                                leftLabel: "Time",
                                leftValue: time,
                                rightIcon: "suitcase",
                                rightLabel: "Occasion",
                                rightValue: occasion
                            )
                        }

                        // Notes
                        VStack(alignment: .leading, spacing: 10) {
                            DetailSectionHeader(title: "Notes")

                            NotesCard(notes: notes)
                        }

                        // Glossary Link
                        Button(action: {
                            isShowingGlossary = true
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "info.circle")
                                    .font(.system(size: 12))
                                Text("What do these terms mean?")
                                    .font(Typography.detailPerfume)
                                    .underline()
                            }
                            .foregroundColor(.black.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 16)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
            .ignoresSafeArea(edges: .top)

            // Floating buttons
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 40, height: 40)
                }
                .glassEffect(.regular.interactive(), in: Circle())

                Spacer()

                Button(action: {
                    perfume.isFavorite.toggle()
                }) {
                    Image(systemName: perfume.isFavorite ? "star.fill" : "star")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(perfume.isFavorite ? Color.appButton : .black)
                        .frame(width: 40, height: 40)
                }
                .glassEffect(.regular.interactive(), in: Circle())
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
        .sheet(isPresented: $isShowingGlossary) {
            FragranceGlossarySheet()
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
