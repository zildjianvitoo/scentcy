import SwiftUI
import Lottie

struct SplashView: View {
    @Binding var showSplash: Bool
    
    var body: some View {
        ZStack {
//            Color.appBackground.ignoresSafeArea()
            Color.init(hex: "FDF8F2")
            
            VStack(spacing: 0) {
               // Spacer()
               
                
                LottieView(animation: .named("cleanedAnim"))
                    .playing(loopMode: .playOnce)
                    .animationDidFinish { completed in
                        withAnimation {
                            showSplash = false
                        }
                    }
                    .frame(width: 172, height: 172)
                    .cornerRadius(24)
                    .clipped(antialiased: true)
               
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .background(Color.appCardBackground)
    }
}


