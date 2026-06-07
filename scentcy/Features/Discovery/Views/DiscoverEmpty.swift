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

                    // MARK: - Title
                    Text("Discover")
                        .font(Typography.display)
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                    // MARK: - Hero Empty State
                    VStack(spacing: 16) {

                        // Bottle illustration placeholder — ganti dengan komponen kamu
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

                    // MARK: - Locked Recommendations
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

                    // MARK: - Locked Scent Profile
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

// MARK: - Bottle Placeholder
struct BottlePlaceholder: View {
    var body: some View {
            ZStack {
                Image("parfume-empty")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 120, height: 140)
        }
}

// MARK: - Locked Perfume Card
struct LockedPerfumeCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.appSecondary.opacity(0.5))
                    .frame(width: 120, height: 140)

                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.7))
                        .frame(width: 32, height: 32)
                    Image(systemName: "lock")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.primary.opacity(0.35))
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.primary.opacity(0.1))
                    .frame(width: 80, height: 10)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.primary.opacity(0.07))
                    .frame(width: 55, height: 8)
            }
            .padding(.horizontal, 2)
        }
        .frame(width: 120)
    }
}

// MARK: - Locked Scent Profile
struct LockedScentProfile: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // Top: cream skeleton area
            ZStack {
                VStack(alignment: .leading, spacing: 6) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.primary.opacity(0.15))
                        .frame(width: 140, height: 10)

                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.primary.opacity(0.1))
                        .frame(width: 90, height: 8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)

                // Blur overlay
                Color.appSecondary.opacity(0.25)
                    .blur(radius: 3)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .background(Color.appSecondary.opacity(0.6))

            // Divider
            Rectangle()
                .fill(Color.primary.opacity(0.06))
                .frame(height: 1)

            // Bottom: swipe to reveal
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.appSecondary)
                        .frame(width: 36, height: 36)
                    Image(systemName: "arrow.right")
                        .foregroundStyle(Color.primary)
                        .font(.system(size: 13, weight: .semibold))
                }

                Text("Swipe to reveal")
                    .font(Typography.bodyStrong)
                    .foregroundStyle(Color.primary)

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.07), radius: 10, x: 0, y: 3)
    }
}

#Preview {
    DiscoverEmpty()
}
