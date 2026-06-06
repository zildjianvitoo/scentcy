//
//  PerfumeDetailView.swift
//  scentcy
//
//  Created by Afra on 06/06/26.
//

import SwiftUI

struct PerfumeDetailView: View {
    var body: some View {
        ScrollView {
            VStack {
                ProductTopBar (icon: "goodgirl1", ProductName: "goodgirl", brand: "carolina Herrera")
                
                Text("Performance")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.horizontal, 41)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                VStack (alignment: .leading, spacing: 32) {
                    SliderIndicator (value: 2, title: "Longevity", low: "Very Weak", high: "Long Lasting")
                    SliderIndicator (value:3, title: "Sillage", low: "Intimate", high: "Enormous")
                }
                Text ("time")
                //font masih belum di naming conv
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.horizontal, 41)
                    .font(.title3)
                    .fontWeight(.semibold)
                HStack(spacing: 18) {
                    TimeOccasionCard(title: "day", icon: "sun.max")
                    
                    TimeOccasionCard(title: "night", icon: "moon")
                    
                    
                }
                Text ("Occasion")
                //font masih belum di naming conv
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.horizontal, 41)
                    .font(.title3)
                    .fontWeight(.semibold)
                HStack(spacing: 18) {
                    TimeOccasionCard(title: "Formal", icon: "jacket")
                    
                    TimeOccasionCard(title: "Informal", icon: "tshirt")
                    
                    
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBackground)
        }
    }
        
}
    

#Preview {
    PerfumeDetailView()
}
