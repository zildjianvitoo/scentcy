import SwiftUI
import Lottie

struct SplashView: View {
    @Binding var showSplash: Bool
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
               
                
                LottieView(animation: .named("animationTR"))
                    .playing(loopMode: .playOnce)
                    .animationDidFinish { completed in
                        withAnimation {
                            showSplash = false
                        }
                    }
                    .frame(width: 450, height: 450)
                    .cornerRadius(24)
                    .clipped(antialiased: true)
               
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .background(Color.appCardBackground)
    }
}

