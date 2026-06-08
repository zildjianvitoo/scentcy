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
    var onDismiss: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Button(action: {
                    onDismiss?()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 36, height: 36)
                        .background(Color.white)
                        .clipShape(Circle())
                }
                .padding(.trailing, 8)
                Spacer()
                HStack {
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
                    .padding(.trailing, 16)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        //font masih belum sesuai sama di hifid
                        //di hifid newyork cust jadi perlu discuss
                        Text (ProductName)
                            .font(Typography.bodyStrong)
                        Text (brand)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    // TODO: Implement Favorite Logic
                }) {
                    Image(systemName: "star")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 36, height: 36)
                        .background(Color.white)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 60)
            .frame(maxWidth: .infinity)
            .frame(height: 200, alignment: .top)
            .background(Color.appPrimary)
        }
    }
}

#Preview {
    ProductTopBar(icon: "goodgirl1", ProductName: "Good Girl", brand: "Carolina Herrera")
}
