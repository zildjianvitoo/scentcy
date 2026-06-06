//
//  TimeOccasionCard.swift
//  scentcy
//
//  Created by Afra on 06/06/26.
//

import SwiftUI

struct TimeOccasionCard: View {
    var title: String
    var icon: String
   // var color: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 40, height: 40)
            Text(title)
        }
            .frame(width: 150, height: 112)
        //ntar mau dikasih fungsi berubah warna tergantung kondisi
            .background(Color.appPrimary)
            .cornerRadius(24)

    }
}

#Preview {
    TimeOccasionCard(title: "day", icon: "sun.max.fill")
}
