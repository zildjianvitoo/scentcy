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
        VStack(spacing: 16) {
            Image(model.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 160)
                .opacity(0.85)

            VStack(spacing: 6) {
                Text(model.title)
                    .font(Typography.sectionTitle)
                    .foregroundStyle(Color.primary)
                    .multilineTextAlignment(.center)

                Text(model.subtitle)
                    .font(Typography.body)
                    .foregroundStyle(Color.textGray)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 40)
    }
}

#Preview {
    VStack {
        JourneyEmpty(tab: .history)
        JourneyEmpty(tab: .saved)
    }
}
