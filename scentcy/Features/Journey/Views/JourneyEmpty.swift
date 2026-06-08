//
//  JourneyEmpty.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 07/06/26.
//

import SwiftUI

struct JourneyEmpty: View {
    let tab: JourneyTab
    private var model: JourneyEmptyModel { JourneyEmptyModel(tab: tab) }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 16) {
                Image(model.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .opacity(0.85)

                VStack(spacing: 6) {
                    Text(model.title)
                        .font(Typography.bodyStrong)
                        .foregroundStyle(Color.primary)
                        .multilineTextAlignment(.center)

                    Text(model.subtitle)
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
