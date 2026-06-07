//
//  PerfumeDetailView.swift
//  scentcy
//
//  Created by Afra on 06/06/26.
//

import SwiftUI

struct PerfumeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    let icon: String
    let productName: String
    let brand: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ProductTopBar(icon: icon, ProductName: productName, brand: brand)
                    
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
                        //Jangan lupa ntar value nya diganti ke logic
                        //dimana warna berubah depends dari database
                        TimeOccasionCard(title: "day", icon: "sun.max", value: 2)
                        
                        TimeOccasionCard(title: "night", icon: "moon", value: 4)
                        
                        
                    }
                    Text ("Occasion")
                    //font masih belum di naming conv
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(.horizontal, 41)
                        .font(.title3)
                        .fontWeight(.semibold)
                    HStack(spacing: 18) {
                        TimeOccasionCard(title: "Formal", icon: "jacket", value: 4)
                        
                        TimeOccasionCard(title: "Informal", icon: "tshirt", value: 2)
                        
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color.appBackground.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                    }
                    .accessibilityLabel("Close")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "star")
                    }
                    .accessibilityLabel("Favorite and close")
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appPrimary, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
        
}
    

#Preview {
    PerfumeDetailView(icon: "goodgirl1", productName: "GoodGirl", brand: "Carolina Herrera")
}
