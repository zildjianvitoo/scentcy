import SwiftUI

struct PerfumeRecommendationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = PerfumeRecommendationViewModel()
    @State private var isShowingCamera = false
    @State private var isShowingFilter = false
    @State private var selectedPerfume: Perfume?
    
    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.perfumes) { perfume in
                        Button {
                            selectedPerfume = perfume
                        } label: {
                            PerfumeListCard(data: perfume)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, Constants.UI.defaultPadding)
                .padding(.top, 100) // Space for the floating header
                .padding(.bottom, 100)
            }
            
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Button(action: { dismiss() }) {
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
                    }
                    
                    Text("Perfumes Recommendation")
                        .font(Typography.metric)
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    
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
                .padding(.top, 10)
                .padding(.bottom, 16)
                .background(
                    Color.white.opacity(0.7)
                        .background(.ultraThinMaterial)
                        .ignoresSafeArea(edges: .top)
                )
                
                Spacer()
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
        .sheet(item: $selectedPerfume) { perfume in
            PerfumeDetailView(perfume: perfume)
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
