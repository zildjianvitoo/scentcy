//
//  DiscoverEmpty.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI

struct DiscoverEmpty: View {
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 32) {

                    Text("Discover")
                        .font(Typography.display)
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                    VStack(spacing: 16) {
                        BottlePlaceholder()

                        VStack(spacing: 6) {
                            Text("Find your next favourite bottle")
                                .font(Typography.bodyStrong)
                                .foregroundStyle(Color.primary)
                                .multilineTextAlignment(.center)

                            Text("Snap a perfume you love and we'll\nfind your next obsession")
                                .font(Typography.body)
                                .foregroundStyle(Color.textGray)
                                .multilineTextAlignment(.center)
                                .lineSpacing(3)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your recommendations will look like this")
                            .font(Typography.description)
                            .foregroundStyle(Color.textGray)
                            .padding(.horizontal, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(0..<3) { _ in
                                    LockedPerfumeCard()
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your scent profile")
                            .font(Typography.description)
                            .foregroundStyle(Color.textGray)
                            .padding(.horizontal, 20)

                        LockedScentProfile()
                            .padding(.horizontal, 20)
                    }

                    Spacer(minLength: 100)
                }
            }
        }
    }
}

#Preview {
    DiscoverEmpty()
}
