//
//  NoseFatigueAlertView.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 12/06/26.
//

import SwiftUI

struct NoseFatigueAlertView: View {
    var onContinue: () -> Void

    var body: some View {
        ZStack {
            Color.primary.opacity(0.4)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.yellow)
                        .font(.system(.title2))

                    Text("Nose Fatigue Warning")
                        .font(Typography.sectionTitle)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Text("Step into fresh air or smell coffee beans to recalibrate your senses.")
                    .font(Typography.body)
                    .foregroundStyle(Color.primary.opacity(0.8))
                    .lineSpacing(4)
                    .frame(maxWidth: .infinity, alignment: .leading)

                PrimaryButton(title: "Continue", action: onContinue)
            }
            .padding(Constants.UI.largePadding)
            .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: Constants.UI.cornerRadius))
            .shadow(color: Color.primary.opacity(0.1), radius: 15, x: 0, y: 10)
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    NoseFatigueAlertView(onContinue: {})
}
