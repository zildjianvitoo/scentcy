//
//  JourneyView.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI

struct JourneyView: View {
    @State private var selectedTab: JourneyTab = .sniffed

    var currentList: [JourneyPerfume] {
        selectedTab == .sniffed ? dummySniffed : dummySaved
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
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(currentList) { perfume in
                                JourneyPerfumeCard(perfume: perfume, showStar: selectedTab == .saved)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                    }
                }
            }
        }
    }
}

#Preview {
    JourneyView()
}
