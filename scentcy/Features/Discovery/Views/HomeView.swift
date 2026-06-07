//
//  HomeView.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 05/06/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {

                    // MARK: - Previously Sniffed
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Previously Sniffed")
                            .font(Typography.bodyStrong)

                        PreviouslySniffedCard()
                    }
                    .padding(.horizontal, 20)

                    // MARK: - Similar Perfumes
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .center, spacing: 4) {
                            Text("Similar Perfumes")
                                .font(Typography.display)

                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.textGray)
                        }
                        .padding(.horizontal, 20)

                        Text("Curated based on your liked perfumes")
                            .font(Typography.notes)
                            .foregroundStyle(Color.textGray)
                            .padding(.horizontal, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(dummyPerfumes) { perfume in
                                    PerfumeCard(data: perfume)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 8)
                        }
                    }

                    // MARK: - Scent Profile
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your Scent Profile")
                            .font(Typography.display)

                        Text("Based on your sniffing journey")
                            .font(Typography.notes)
                            .foregroundStyle(Color.textGray)

                        ScentProfileCard()
                            .padding(.top, 8)
                    }
                    .padding(.horizontal, 20)

                    Spacer(minLength: 100)
                }
                .padding(.top, 20)
            }

            // BottomBar()
        }
    }
}

#Preview {
    HomeView()
}
