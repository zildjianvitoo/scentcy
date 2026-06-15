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
    @State private var isShowingManualInput = false
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
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.black)
                                .frame(width: 36, height: 36)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, Constants.UI.defaultPadding)

                    Spacer()

                    // Hint pill
                    Text("Capture a perfume you like")
                        .font(Typography.body)
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
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

                    // Scanner reticle
                    ScannerReticleShape()
                        .stroke(
                            Color.white,
                            style: StrokeStyle(
                                lineWidth: 4,
                                lineCap: .round,
                                lineJoin: .round
                            )
                        )
                        .frame(width: 250, height: 250)

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
                    Button(action: { isShowingManualInput = true }) {
                        Text("Enter Manually")
                            .font(Typography.body)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .glassEffect(.regular.interactive(), in: Capsule())
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
            .overlay {
                if viewModel.isProcessing {
                    ZStack {
                        Color.black.opacity(0.4).ignoresSafeArea()
                        VStack(spacing: 16) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.5)
                            Text("Memproses Gambar...")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        .padding(32)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(16)
                    }
                } else if viewModel.isShowingNoseFatigueAlert {
                    NoseFatigueAlertView {
                        viewModel.dismissNoseFatigueAlert()
                    }
                }
            }
            .onAppear { 
                viewModel.dbPerfumes = allPerfumes
                viewModel.startCamera() 
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showHint = false
                }
            }
            .onDisappear {
                viewModel.stopCamera()
                viewModel.resetPhotoCounter()
            }
            .navigationDestination(isPresented: $viewModel.isShowingResultSheet) {
                if let matched = viewModel.matchedPerfume {
                    PerfumeDetailView(perfume: matched)
                }
            }
            .sheet(isPresented: $viewModel.isShowingNotFoundSheet) {
                PerfumeNotFoundSheet(
                    onTryAgain: {
                        viewModel.isShowingNotFoundSheet = false
                    }
                )
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $isShowingManualInput) {
                ManualInputSheet(
                    isPresented: $isShowingManualInput,
                    currentDetent: $manualInputDetent,
                    onSelectPerfume: { name, brand in
                        if let found = allPerfumes.first(where: { $0.name == name && $0.brand == brand }) {
                            found.isScanned = true
                            found.scannedAt = Date()
                            try? modelContext.save()
                            viewModel.matchedPerfume = found
                            viewModel.isShowingResultSheet = true
                        }
                    }
                )
                .presentationDetents([.height(180), .large], selection: $manualInputDetent)
                .presentationDragIndicator(.visible)
                .presentationBackgroundInteraction(.enabled(upThrough: .height(180)))
            }
        }
    }
}

#Preview {
    CameraView()
}
