//
//  NoteChip.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 14/06/26.
//


import SwiftUI

struct NoteChip: View {
    let label: String

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(Color.appPrimary)
                .frame(width: 5, height: 5)

            Text(label)
                .font(Typography.scentNotes)
                .foregroundStyle(Color.primary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(Color.white.opacity(0.7))
                .overlay(
                    Capsule()
                        .strokeBorder(Color.primary.opacity(0.1), lineWidth: 1)
                )
        )
    }
}
