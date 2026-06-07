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
                        .font(Typography.bodyStrong)
                        .foregroundColor(.white)
                        .padding(.vertical, Constants.UI.defaultPadding)
                        .frame(maxWidth: .infinity)
                        .background(Color.appSecondary)
                        .cornerRadius(Constants.UI.cornerRadius)
                }
                .padding(.horizontal, 40)
                
                NavigationLink(destination: PerfumeRecommendationView()) {
                    Text("Rekomendasi Parfum")
                        .font(Typography.bodyStrong)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Constants.UI.defaultPadding)
                        .background(Color.appPrimary)
                        .cornerRadius(Constants.UI.cornerRadius)
                }
                .padding(.horizontal, 40)
            }
            .padding()
            .fullScreenCover(isPresented: $isShowingCamera) {
                CameraView()
            }
        }
    }
}

#Preview {
    ContentView()
}
