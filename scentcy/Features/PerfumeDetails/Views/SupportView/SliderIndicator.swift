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
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(Typography.bodyStrong)
                .foregroundColor(.primary)
            
            ProgressView(value: min(max(value, 0), 5), total: 5.0)
            
            HStack {
                Text(low)
                Spacer()
                Text(high)
            }
            .font(Typography.body)
            .foregroundColor(.primary)
        }
        .padding(Constants.UI.defaultPadding)
        .frame(maxWidth: .infinity)
        .background(Color.appCardBackground)
        .cornerRadius(Constants.UI.cornerRadius)
    }
}

#Preview {
    SliderIndicator(value: 2.0, title: "Longevity", low: "3 hour", high: "8 hour")
}
