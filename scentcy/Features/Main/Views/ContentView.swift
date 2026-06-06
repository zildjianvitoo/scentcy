//
//  ContentView.swift
//  scentcy
//
//  Created by Zildjian Vito  on 03/06/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingCamera = false
    @State private var isShowingModal = false
    
    var body: some View {
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
            
            Button(action: {
                isShowingModal = true
            }) {
                Text ("buka detail")
            }
            .buttonStyle(.borderedProminent)
           
        }
        .padding()
        .fullScreenCover(isPresented: $isShowingCamera) {
            CameraView()
        }
        .sheet(isPresented: $isShowingModal, content: {
            PerfumeDetailView()
        })
    }
}

#Preview {
    ContentView()
}
