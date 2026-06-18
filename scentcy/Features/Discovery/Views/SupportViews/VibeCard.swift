//
//  VibeCard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 14/06/26.
//

import SwiftUI

struct VibeCard: View {
    var vibeName: String
    var vibeIcon: String
    var aromaNotes: [String]

    @State private var isFlipped = false

    var body: some View {
        ZStack {
            cardFront
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.appPrimary)
                        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
                )
                .opacity(isFlipped ? 0 : 1)
            
            cardBack
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
                )
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
    }
    
    // Front Card
    private var cardFront: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Scent Signature")
                        .font(Typography.detailPerfume)
                        .foregroundStyle(Color.primary.opacity(0.6))

                    Text(vibeName)
                        .font(Typography.metric)
                        .foregroundStyle(Color.primary)
                }

                Spacer()
                Button(action: {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        isFlipped.toggle()
                    }
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.trianglehead.2.clockwise")
                            .font(Typography.flashcard)
                        Text("Tap card to flip & learn")
                            .font(Typography.flashcard)
                    }
                    .foregroundStyle(Color.primary.opacity(0.6))
                }
            }
            .buttonStyle(.bordered)
            .tint(Color(hex: "EEDDCC"))
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 16)

            Divider()
                .background(Color.primary.opacity(0.1))
                .padding(.horizontal, Constants.UI.screenPadding)

            VStack(alignment: .leading, spacing: 12) {
                Text("Your preferred scents (notes)")
                    .font(Typography.detailPerfume)
                    .foregroundStyle(Color.primary)

                FlowLayout(spacing: 8) {
                    ForEach(aromaNotes, id: \.self) { note in
                        ChipView(label: note, style: .note)
                    }
                }
                .padding(.bottom, 4)
            }
            .tint(Color.primary.opacity(0.6))
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.vertical, Constants.UI.defaultPadding)
        }
    }
    
    // Back Card (Ready to be customized)
    private var cardBack: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(vibeName)
                        .font(Typography.metric)
                        .foregroundStyle(Color.primary)
                }

                Spacer()
                Button(action: {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        isFlipped.toggle()
                    }
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.trianglehead.2.clockwise")
                            .font(Typography.flashcard)
                        Text("Tap to Flip back")
                            .font(Typography.flashcard)
                    }
                    .foregroundStyle(Color.primary.opacity(0.6))
                }
            }
            .buttonStyle(.bordered)
            .tint(Color.primary.opacity(0.1))
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.top, Constants.UI.screenPadding)
            .padding(.bottom, Constants.UI.defaultPadding)

            Divider()
                .background(Color.primary.opacity(0.1))
                .padding(.horizontal, Constants.UI.screenPadding)
            
            VStack(alignment: .leading, spacing: 12) {
                //ntar tolong diganti ini placeholder pake data explanation dari json nya to
                Text("A deep, boozy, and woody note with sweet, oak-barrel nuances.")
                    .lineLimit(4)
                    .font(Typography.detailPerfume)
                    .foregroundStyle(Color.primary.opacity(0.8))
                    .padding(.bottom, 4)
                HStack {
                    Spacer()
                    Image(systemName: vibeIcon)
                        .font(.system(size: 48))
                        .foregroundStyle(Color.primary.opacity(0.12))
                        
                }
            }
            .padding(.horizontal, Constants.UI.screenPadding)
            .padding(.vertical, Constants.UI.defaultPadding)
        }
    }
}

#Preview {
    VibeCard(vibeName: "Woody", vibeIcon: "tree", aromaNotes: ["Cedar", "Amber"])
        .padding()
        .background(Color.appBackground)
}
