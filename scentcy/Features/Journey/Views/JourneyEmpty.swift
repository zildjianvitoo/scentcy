//
//  JourneyEmpty.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI

struct JourneyEmpty: View {
    let tab: JourneyTab

    var title: String {
        tab == .sniffed ? "No sniffed perfume yet" : "Nothing Saved Yet"
    }

    var subtitle: String {
        tab == .sniffed
            ? "Every perfume you snap will leave\na trace here"
            : "Tap ★ on any recommendations\nperfume to keep it here"
    }

    var imageName: String {
        tab == .sniffed ? "SniffedEmpty" : "SavedEmpty"
    }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 16) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .opacity(0.85)

                VStack(spacing: 6) {
                    Text(title)
                        .font(Typography.bodyStrong)
                        .foregroundStyle(Color.primary)
                        .multilineTextAlignment(.center)

                    Text(subtitle)
                        .font(Typography.body)
                        .foregroundStyle(Color.textGray)
                        .multilineTextAlignment(.center)
                        .lineSpacing(3)
                }
            }
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    VStack {
        JourneyEmpty(tab: .sniffed)
        JourneyEmpty(tab: .saved)
    }
}
