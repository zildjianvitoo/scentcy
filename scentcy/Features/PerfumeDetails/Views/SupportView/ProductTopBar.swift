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
    
    @State private var isAnimating = false
    
    var body: some View {
        HStack {
            // Product Info (Image + Text)
            HStack(spacing: 16) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.UI.cornerRadius))
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
                    .opacity(isAnimating ? 1.0 : 0.0)
                    .onAppear {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                            isAnimating = true
                        }
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(ProductName)
                        .font(.title3)
                        .fontWeight(.semibold)
                    // Using appropriate size
                    Text(brand)
                        .font(Typography.body)
                }
                .fontDesign(.serif)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
        .padding(.top, 60)
        .padding(.bottom, 24)
        .background(Color.appPrimary)
    }
}

#Preview {
    ProductTopBar(icon: "goodgirl1", ProductName: "Good Girl", brand: "Carolina Herrera")
}
