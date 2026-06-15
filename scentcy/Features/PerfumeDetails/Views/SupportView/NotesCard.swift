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
                NoteChip(label: note)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
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
