//
//  ProductCard.swift
//  scentcy
//
//  Created by Afra on 05/06/26.
//

import SwiftUI

struct ProductCardGrid: View {
    var name: String
    var icon: String
    var brand: String
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
               
                Color.gray.opacity(0.5)
                    .frame(width: 152, height: 248)
                   
                    .mask(
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                    )
                
            
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color.black, radius: 10)
            }
            .frame(width: 152, height: 248)
            
            VStack (alignment: .leading){
                Text(name)
                    .font(.body.bold())
                    .frame(width: 152)
                    .lineLimit(1)
                
                Text(brand)
                    .font(.subheadline)
                    .frame(width: 152)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    ProductCardGrid(name: "GoodGirl", icon: "cdnIntenseMan", brand: "Carolina Herrera")
}
