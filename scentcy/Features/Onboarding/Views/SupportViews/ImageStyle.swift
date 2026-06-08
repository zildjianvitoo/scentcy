//
//  ImageStyle.swift
//  scentcy
//
//  Created by Afra on 08/06/26.


import SwiftUI

struct ImageCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipped()
            .frame(width: 316, height: 357)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(Constants.UI.cornerRadius)
    }
}

extension View {
    func imageStyle() -> some View {
        self.modifier(ImageCardModifier())
           
        
    }
}
