import SwiftUI

struct PerfumeRecommendationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = PerfumeRecommendationViewModel()
    @State private var isShowingCamera = false
    @State private var isShowingFilter = false
    
    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                Button(action: { dismiss() }) {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .font(Typography.bodyStrong)
                    .foregroundColor(.black)
                    .padding(.horizontal, Constants.UI.defaultPadding)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal, Constants.UI.defaultPadding)
                .padding(.top, 10)
                
                HStack {
                    Text("Similar Perfumes")
                        .font(Typography.display)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        isShowingFilter = true
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.system(size: 28))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, Constants.UI.defaultPadding)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.perfumes) { perfume in
                            PerfumeCardView(perfume: perfume)
                        }
                    }
                    .padding(.horizontal, Constants.UI.defaultPadding)
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    CameraFloatingButton {
                        isShowingCamera = true
                    }
                    .padding(24)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $isShowingCamera) {
            CameraView()
        }
        .sheet(isPresented: $isShowingFilter) {
            PerfumeFilterSheet(viewModel: viewModel)
        }
    }
}

#Preview {
    NavigationStack {
        PerfumeRecommendationView()
    }
}
