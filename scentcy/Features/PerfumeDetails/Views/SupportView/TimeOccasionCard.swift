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
        .frame(maxWidth: .infinity)
        .frame(height: 112)
    //ntar disini pake logic warna tergantung isi database
    //ini placeholder sementara just for coded ui will do later
            .background(value > 3 ? Color.babyBlue : Color.white)
            .cornerRadius(Constants.UI.cornerRadius)

    }
}

#Preview {
    TimeOccasionCard(title: "day", icon: "sun.max.fill", value: 4)
}
