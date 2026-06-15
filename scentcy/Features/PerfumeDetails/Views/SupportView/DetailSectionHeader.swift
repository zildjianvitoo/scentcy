//
//  DetailSectionHeader.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 15/06/26.
//

import SwiftUI

struct DetailSectionHeader: View {
    let title: String

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(Color.appButton)
                .frame(width: 8, height: 8)

            Text(title)
                .font(Typography.bodyStrong)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    DetailSectionHeader(title: "Performance")
        .padding()
        .background(Color.appBackground)
}
