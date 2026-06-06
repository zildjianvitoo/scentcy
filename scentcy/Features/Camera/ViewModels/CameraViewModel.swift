import SwiftUI
import Combine
import AVFoundation

class CameraViewModel: ObservableObject {
    @Published var session: AVCaptureSession = AVCaptureSession()
    @Published var isCameraGranted: Bool = false
    @Published var capturedImage: UIImage?
    @Published var isProcessing: Bool = false
    @Published var isShowingNotFoundSheet: Bool = false
    @Published var isShowingNoseFatigueAlert: Bool = false
    @Published var photoCaptureCount: Int = 0
    
    private let cameraService = CameraService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.session = cameraService.session
        
        // Observe permission
        cameraService.$isGranted
            .assign(to: \.isCameraGranted, on: self)
            .store(in: &cancellables)
            
        // Observe captured image
        cameraService.onImageCaptured = { [weak self] image in
            self?.capturedImage = image
            self?.photoCaptureCount += 1
            self?.processImage(image)
        }
    }
    
    func capturePhoto() {
        cameraService.capturePhoto()
    }
    
    func stopCamera() {
        cameraService.stopSession()
    }
    
    func resetPhotoCounter() {
        self.photoCaptureCount = 0
    }
    
    func dismissNoseFatigueAlert() {
        self.isShowingNoseFatigueAlert = false
        self.photoCaptureCount = 0 // Reset counter to allow next 4 photos
    }
    
    /// Fungsi untuk memproses gambar dan mengirim ke backend/AI
    private func processImage(_ image: UIImage) {
        self.isProcessing = true
        
        // TODO: Implementasi panggil API Backend / AI disini
        print("Mulai memproses gambar dan mengirim ke Backend/AI...")
        
        // Simulasi delay pengiriman network / AI processing selama 2 detik
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            print("Berhasil diproses oleh Backend/AI!")
            self.isProcessing = false
            
            if self.photoCaptureCount >= 4 {
                // Tampilkan Nose Fatigue Warning kustom dialog
                self.isShowingNoseFatigueAlert = true
            } else {
                // Tampilkan bottom sheet "Perfume Not Found"
                self.isShowingNotFoundSheet = true
            }
        }
    }
}
