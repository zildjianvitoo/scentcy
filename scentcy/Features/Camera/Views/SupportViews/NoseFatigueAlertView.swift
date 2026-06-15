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
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 24))

                    Text("Nose Fatigue Warning")
                        .font(Typography.sectionTitle)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Text("Step into fresh air or smell coffee beans to recalibrate your senses.")
                    .font(Typography.body)
                    .foregroundStyle(Color.black.opacity(0.8))
                    .lineSpacing(4)
                    .frame(maxWidth: .infinity, alignment: .leading)

                PrimaryButton(title: "Continue", action: onContinue)
            }
            .padding(24)
            .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: Constants.UI.cornerRadius))
            .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 10)
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    NoseFatigueAlertView(onContinue: {})
}
