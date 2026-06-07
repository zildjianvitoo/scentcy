//
//  ContentView.swift
//  scentcy
//
//  Created by Zildjian Vito  on 03/06/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingCamera = false
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                
                Button(action: {
                    isShowingCamera = true
                }) {
                    Text("Buka Kamera")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                
                NavigationLink(destination: PerfumeListMockView()) {
                    Text("buka detail")
                }
                .buttonStyle(.borderedProminent)
               
            }
            .padding()
        }
      
    }
}

#Preview {
    ContentView()
}

