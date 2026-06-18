//
//  NotesCard.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 15/06/26.
//

import SwiftUI

struct NotesCard: View {
    let notes: [String]

    var body: some View {
        FlowLayout(spacing: 8) {
            ForEach(notes, id: \.self) { note in
                ChipView(label: note, style: .note)
            }
        }
        .padding(Constants.UI.defaultPadding)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.appCardBackground)
                .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Color.appButton.opacity(0.4), lineWidth: 1)
                )
        )
    }
}

#Preview {
    NotesCard(notes: ["Mandarin Orange", "Amber", "Cedar", "Orange", "Batam Orange"])
        .padding()
        .background(Color.appBackground)
}
