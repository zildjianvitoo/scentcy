//
//  Camera.swift
//  scentcy
//
//  Created by Zildjian Vito  on 04/06/26.
//

import SwiftUI
import SwiftData

struct CameraView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allPerfumes: [Perfume]
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CameraViewModel()
    @State private var manualInputDetent: PresentationDetent = .height(180)
    @State private var showHint = true

    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isCameraGranted {
                    CameraPreviewView(session: viewModel.session)
                        .ignoresSafeArea()
                } else {
                    Color.black.ignoresSafeArea()
                }

                VStack(spacing: 0) {
                    // Close button
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .font(.system(.callout, weight: .bold))
                                .foregroundColor(.primary)
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
                        Spacer()
                    }
                    .padding(.horizontal, Constants.UI.largePadding)
                    .padding(.top, Constants.UI.defaultPadding)

                    Text("Capture a perfume you like")
                        .font(Typography.body)
                        .foregroundColor(.primary)
                        .padding(.horizontal, Constants.UI.defaultPadding)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.85))
                                .shadow(color: .black.opacity(0.15), radius: 10, y: 4)
                        )
                        .padding(.bottom, 32)
                        .opacity(showHint ? 1 : 0)
                        .scaleEffect(showHint ? 1 : 0.8)
                        .offset(y: showHint ? 0 : -30)
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: showHint)
 
                  
                    Spacer()
                  
                    

                    // Shutter button
                    Button(action: { viewModel.capturePhoto() }) {
                        Circle()
                            .strokeBorder(Color.white, lineWidth: 4)
                            .frame(width: 72, height: 72)
                            .overlay(
                                Circle()
                                    .fill(Color.appButton)
                                    .frame(width: 58, height: 58)
                            )
                            .contentShape(Circle())
                    }
                    .buttonStyle(ShutterButtonStyle())
                    .padding(.bottom, 80)

                    // Enter Manually button
                    Button(action: { viewModel.activeSheet = .manualInput }) {
                        Text("Enter Manually")
                            .font(Typography.body)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                Capsule()
                                    .fill(Color.white.opacity(0.7))
                                    .background(.ultraThinMaterial)
                            )
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .strokeBorder(Color.white, lineWidth: 1)
                            )
                    }
                    .padding(.horizontal, Constants.UI.largePadding)
                    .padding(.bottom, 40)
                }
            }
            .overlay {
                if viewModel.isProcessing {
                    ZStack {
                        Color.primary.opacity(0.4).ignoresSafeArea()
                        VStack(spacing: 16) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.5)
                            Text("Memproses Gambar...")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        .padding(32)
                        .background(Color.primary.opacity(0.7))
                        .cornerRadius(16)
                    }
                } else if viewModel.isShowingNoseFatigueAlert {
                    NoseFatigueAlertView {
                        viewModel.dismissNoseFatigueAlert()
                        dismiss()
                        if let matchedName = viewModel.matchedPerfume?.name {
                            NotificationCenter.default.post(name: NSNotification.Name("ShowAddPerfumeToast"), object: matchedName)
                        }
                    }
                }
            }
            .onAppear { 
                viewModel.dbPerfumes = allPerfumes
                viewModel.startCamera() 
                Task {
                    try? await Task.sleep(for: .seconds(5))
                    showHint = false
                }
            }
            .onDisappear {
                viewModel.stopCamera()
            }
            .navigationDestination(isPresented: $viewModel.isShowingResultSheet) {
                if let matched = viewModel.matchedPerfume {
                    PerfumeDetailView(perfume: matched)
                }
            }
            .sheet(item: $viewModel.activeSheet) { sheet in
                switch sheet {
                case .notFound:
                    PerfumeNotFoundSheet(
                        onTryAgain: {
                            viewModel.activeSheet = nil
                        }
                    )
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                case .manualInput:
                    ManualInputSheet(
                        isPresented: Binding(
                            get: { viewModel.activeSheet == .manualInput },
                            set: { if !$0 { viewModel.activeSheet = nil } }
                        ),
                        currentDetent: $manualInputDetent,
                        allPerfumes: allPerfumes,
                        onSelectPerfume: { name, brand in
                            if let found = allPerfumes.first(where: { $0.name == name && $0.brand == brand }) {
                                viewModel.markPerfumeAsScanned(found, context: modelContext)
                                
                                Task {
                                    try? await Task.sleep(for: .seconds(0.3))
                                    if !viewModel.isShowingNoseFatigueAlert {
                                        dismiss()
                                        NotificationCenter.default.post(name: NSNotification.Name("ShowAddPerfumeToast"), object: found.name)
                                    }
                                }
                                }
                            }
                        }
                    )
                    .presentationDetents([.height(180), .large], selection: $manualInputDetent)
                    .presentationDragIndicator(.visible)
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(180)))
                case .confirmation:
                    if let matched = viewModel.matchedPerfume {
                        PerfumeConfirmationSheet(
                            perfumeName: matched.name,
                            brandName: matched.brand,
                            perfumeImage: Image(matched.imageName),
                            onNo: {
                                viewModel.activeSheet = nil
                                viewModel.matchedPerfume = nil
                            },
                            onYes: {
                                viewModel.activeSheet = nil
                                viewModel.markPerfumeAsScanned(matched, context: modelContext)
                                
                                Task {
                                    try? await Task.sleep(for: .seconds(0.3))
                                    if !viewModel.isShowingNoseFatigueAlert {
                                        dismiss()
                                        NotificationCenter.default.post(name: NSNotification.Name("ShowAddPerfumeToast"), object: matched.name)
                                    }
                                }
                            }
                        )
                        .presentationDetents([.height(480)])
                        .presentationDragIndicator(.visible)
                    }
                }
            }
        }
    }
}

#Preview {
    CameraView()
}
