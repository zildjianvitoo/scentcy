//
//  ProductCard.swift
//  scentcy
//
//  Created by Afra on 05/06/26.
//
//import SwiftUI
//
//struct ProductCardGrid:View {
//    var icon: String
//    var name: String
//    var brand: String
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Image(icon)
//                .resizable()
//                .scaledToFill()
//                .frame(width: 152 , height: 248)
//               .background(Color.gray.opacity(0.5))
//                .cornerRadius(16)
//            Text (name)
//                .font(.body.bold())
//            Text (brand)
//                .font(.subheadline)
//        }
//
//    }
//}
//#Preview {
//    ProductCardGrid(icon: "goodgirl1", name: "GoodGirl", brand: "Carolina Herrera")
//}
import SwiftUI

struct ProductCardGrid: View {
    var icon: String
    var name: String
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
            
            
            Text(name)
                .font(.body.bold())
            
            Text(brand)
                .font(.subheadline)
        }
    }
}

#Preview {
    ProductCardGrid(icon: "goodgirl1", name: "GoodGirl", brand: "Carolina Herrera")
}
