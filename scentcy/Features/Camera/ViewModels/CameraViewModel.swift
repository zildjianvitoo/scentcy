import SwiftUI
import Combine
import AVFoundation

class CameraViewModel: ObservableObject {
    @Published var session: AVCaptureSession = AVCaptureSession()
    @Published var isCameraGranted: Bool = false
    @Published var capturedImage: UIImage?
    @Published var isProcessing: Bool = false
    @Published var isShowingResultSheet: Bool = false
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
    
    private func processImage(_ image: UIImage) {
        if self.photoCaptureCount >= 4 {
            // Tampilkan Nose Fatigue Warning kustom dialog
            self.isShowingNoseFatigueAlert = true
        } else {
            // Langsung tampilkan result sheet, classification dilakukan di view tersebut
            self.isShowingResultSheet = true
        }
    }
}
