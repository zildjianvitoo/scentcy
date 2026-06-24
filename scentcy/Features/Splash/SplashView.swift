import SwiftUI
import Lottie

struct SplashView: View {
    @Binding var showSplash: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "EAF3FA"), // Light blueish
                    Color(hex: "F5D0B5")  // Peach orange
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
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
    }
}


