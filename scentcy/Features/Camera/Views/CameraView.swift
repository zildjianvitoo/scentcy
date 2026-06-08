//
//  Camera.swift
//  scentcy
//
//  Created by Zildjian Vito  on 04/06/26.
//

import SwiftUI

struct CameraView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CameraViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isCameraGranted {
                    CameraPreviewView(session: viewModel.session)
                        .ignoresSafeArea()
                } else {
                    Color.black.ignoresSafeArea()
                    VStack {
                        Text("Meminta izin kamera...")
                            .foregroundColor(.white)
                    }
                }

                VStack {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                                .frame(width: 36, height: 36)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, Constants.UI.defaultPadding)

                    Spacer()

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

                Text(
                    "Capture perfumes you\nfound interesting so we can\ngenerate results for you!"
                )
                .multilineTextAlignment(.center)
                .font(Typography.body)
                .foregroundColor(.black)
                .padding(.vertical, Constants.UI.defaultPadding)
                .padding(.horizontal, 24)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)

                    Button(action: {
                        viewModel.capturePhoto()
                    }) {
                        ZStack {
                            Circle()
                                .stroke(Color.white.opacity(0.8), lineWidth: 4)
                                .frame(width: 72, height: 72)

                            Circle()
                                .fill(Color.white.opacity(0.5))  // Bisa diubah solid jika ditekan
                                .frame(width: 58, height: 58)
                        }
                    }
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
            .onDisappear {
                viewModel.stopCamera()
                viewModel.resetPhotoCounter()
            }
            .navigationDestination(isPresented: $viewModel.isShowingResultSheet) {
                if let capturedImage = viewModel.capturedImage {
                    PerfumeListMockView(capturedImage: capturedImage)
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
        }
    }
}

#Preview {
    CameraView()
}
