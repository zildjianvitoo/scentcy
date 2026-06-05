//
//  OnboardingProgressDots.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI


struct OnboardingProgressDots: View {
    let currentPage: Int
    let totalPages: Int = 4

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...totalPages, id: \.self) { page in
                Capsule()
                    .fill(page == currentPage ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: page == currentPage ? 20 : 8, height: 8)
                    .animation(.easeInOut(duration: 0.2), value: currentPage)
            }
        }
    }
}
