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
    var value: Int
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 40, height: 40)
            Text(title)
        }
            .frame(width: 150, height: 112)
    //ntar disini pake logic warna tergantung isi database
    //ini placeholder sementara just for coded ui will do later
            .background(value > 3 ? Color.appPrimary : Color.white)
            .cornerRadius(24)

    }
}

#Preview {
    TimeOccasionCard(title: "day", icon: "sun.max.fill", value: 4)
}
