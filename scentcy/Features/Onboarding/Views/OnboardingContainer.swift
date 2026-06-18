import SwiftUI

struct OnboardingContainer: View {
    @State private var currentPage: Int = 1
    
    var body: some View {
        NavigationStack {
            TabView(selection: $currentPage) {
                OnboardingWhat(currentPage: $currentPage)
                    .tag(1)
                
                OnboardingHow(currentPage: $currentPage)
                    .tag(2)
                
                OnboardingHowResult(currentPage: $currentPage)
                    .tag(3)
                
                OnboardingHowValue(currentPage: $currentPage)
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(hex: "F5E6D1"), location: 0.0),
                        .init(color: Color(hex: "F4E2CA"), location: 0.15),
                        .init(color: Color(hex: "FEFCFB"), location: 0.45)
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    OnboardingContainer()
}
