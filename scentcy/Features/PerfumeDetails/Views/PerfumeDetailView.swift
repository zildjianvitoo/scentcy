//
//  PerfumeDetailView.swift
//  scentcy
//
//  Created by Afra on 06/06/26.
//

import SwiftUI

struct PerfumeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isSaved = false

    let icon: String
    let productName: String
    let brand: String

    // Mock data
    private let scentNotes = ["Woody", "Spicy"]
    private let longevity = "8 hrs"
    private let sillage = "Moderate"
    private let time = "Day & Night"
    private let occasion = "Informal"
    private let notes = ["Mandarin Orange", "Amber", "Cedar", "Orange", "Batam Orange"]

    var body: some View {
        ZStack(alignment: .top) {
            Color.appBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Hero image with gradient
                    ZStack {
                        LinearGradient(
                            colors: [Color.appPrimary.opacity(0.5), Color.appBackground],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 260)

                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 220)
                            .padding(.top, 60)
                    }

                    // Title + notes
                    VStack(spacing: 4) {
                        Text(productName)
                            .font(Typography.bodyStrong)
                            .foregroundColor(.black)

                        Text(brand)
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

                Button(action: { isSaved.toggle() }) {
                    Image(systemName: isSaved ? "star.fill" : "star")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(isSaved ? Color.appButton : .black)
                        .frame(width: 40, height: 40)
                }
                .glassEffect(.regular.interactive(), in: Circle())
            }
            .padding(.horizontal, 20)
            .padding(.top, 60)
        }
    }
}

#Preview {
    PerfumeDetailView(
        icon: "goodgirl1",
        productName: "Libre Intense EDP",
        brand: "Yves Saint Laurent"
    )
}
