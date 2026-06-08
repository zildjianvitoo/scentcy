import SwiftUI

struct OnboardingToolbarModifier: ViewModifier {
    var currentPage: Int
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: BottomTabBar().navigationBarBackButtonHidden(true)) {
                        Text("Skip")
                            
                    }
                }
                ToolbarItem(placement: .principal) {
                    OnboardingProgressDots(currentPage: currentPage)
                }
            }
    }
}

extension View {
    func onboardingToolbar(currentPage: Int) -> some View {
        self.modifier(OnboardingToolbarModifier(currentPage: currentPage))
    }
}
