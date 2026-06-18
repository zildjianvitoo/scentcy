import SwiftUI

struct OnboardingToolbarModifier: ViewModifier {
    @Binding var currentPage: Int

    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            // Custom Toolbar
            ZStack {
                HStack {
                    if currentPage > 1 {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentPage -= 1
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(Color.primary)
                                .frame(width: 40, height: 40)
                                .background(
                                    Circle()
                                        .fill(Color.white.opacity(0.7))
                                        .background(.ultraThinMaterial)
                                )
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .strokeBorder(Color.white, lineWidth: 1)
                                )
                                .frame(width: 44, height: 44, alignment: .leading)
                        }
                    } else {
                        Spacer().frame(width: 44) // placeholder for alignment
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: BottomTabBar().navigationBarBackButtonHidden(true)) {
                        Text("Skip")
                            .foregroundStyle(Color.primary)
                            .frame(height: 44, alignment: .trailing)
                    }
                }
                
                OnboardingProgressDots(currentPage: currentPage)
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            
            content
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

extension View {
    func onboardingToolbar(currentPage: Binding<Int>) -> some View {
        self.modifier(OnboardingToolbarModifier(currentPage: currentPage))
    }
}
