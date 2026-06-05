//
//  ProductCard.swift
//  scentcy
//
//  Created by Afra on 05/06/26.
//
import SwiftUI

struct ProductCardGrid:View {
    var icon: String
    var name: String
    var brand: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(icon)
                .resizable()
                .scaledToFill()
                .frame(width: 152 , height: 248)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(16)
            Text (name)
                .font(.body.bold())
            Text (brand)
                .font(.subheadline)
        }
        
    }
}
#Preview {
    ProductCardGrid(icon: "goodgirl", name: "GoodGirl", brand: "Carolina Herrera")
}
