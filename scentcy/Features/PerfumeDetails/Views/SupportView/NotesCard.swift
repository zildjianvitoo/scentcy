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
    }
}

#Preview {
    NotesCard(notes: ["Mandarin Orange", "Amber", "Cedar", "Orange", "Batam Orange"])
        .padding()
        .background(Color.appBackground)
}
