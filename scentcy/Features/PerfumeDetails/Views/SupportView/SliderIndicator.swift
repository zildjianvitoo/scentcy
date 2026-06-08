//
//  SliderIndicator.swift
//  scentcy
//
//  Created by Afra on 05/06/26.
//

import SwiftUI

struct SliderIndicator: View {
    var value: Double
    var title: String
    var low: String
    var high: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(Typography.bodyStrong)
                //ntar value get dari database
                ProgressView(value: min(max(value, 0), 5), total: 5.0)
                HStack {
                    Text(low)
                    Spacer()
                    Text(high)
                }
            }
            .frame(width: 296)
        }
        .frame(width: 320, height: 130)
        
        .background(Color.white)
        .cornerRadius(Constants.UI.cornerRadius)
        
    }
}

#Preview {
    SliderIndicator(value: 2.0, title: "Longevity", low: "Very Weak", high: "Long Lasting")
}
