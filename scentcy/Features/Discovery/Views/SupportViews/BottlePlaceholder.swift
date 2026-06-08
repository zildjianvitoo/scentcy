//
//  BottlePlaceholder.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import SwiftUI

struct BottlePlaceholder: View {
    var body: some View {
        ZStack {
            Image("parfume-empty")
                .resizable()
                .scaledToFit()
        }
        .frame(width: 120, height: 140)
    }
}

#Preview {
    BottlePlaceholder()
}


