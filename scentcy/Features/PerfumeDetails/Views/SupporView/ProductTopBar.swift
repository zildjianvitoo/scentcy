//
//  ProductTopBar.swift
//  scentcy
//
//  Created by Afra on 06/06/26.
//

import SwiftUI

struct ProductTopBar: View {
    var icon: String
    var ProductName: String
    var brand: String
    
    var body: some View {
        HStack{
            ZStack {
               
                Color.gray.opacity(0.5)
                    .frame(width: 64, height: 150)
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
            .frame(width: 64, height: 150)
            
            VStack(alignment: .leading, spacing: 4) {
                //font masih belum sesuai sama di hifid
                //di hifid newyork cust jadi perlu discuss
            Text (ProductName)
                    .font(Typography.bodyStrong)
            Text (brand)
                
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.appSecondary)
    }
       
}

#Preview {
    ProductTopBar(icon: "goodgirl1", ProductName: "Good Girl", brand: "Carolina Herrera")
}
