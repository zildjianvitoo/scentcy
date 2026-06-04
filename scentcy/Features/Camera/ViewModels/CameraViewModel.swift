import SwiftUI
import Combine
import AVFoundation

class CameraViewModel: ObservableObject {
    @Published var session: AVCaptureSession = AVCaptureSession()
    @Published var isCameraGranted: Bool = false
    @Published var capturedImage: UIImage?
    @Published var isProcessing: Bool = false
    
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
            self?.processImage(image)
        }
    }
    
    func capturePhoto() {
        cameraService.capturePhoto()
    }
    
    func stopCamera() {
        cameraService.stopSession()
    }
    
    /// Fungsi untuk memproses gambar dan mengirim ke backend/AI
    private func processImage(_ image: UIImage) {
        self.isProcessing = true
        
        // TODO: Implementasi panggil API Backend / AI disini
        print("Mulai memproses gambar dan mengirim ke Backend/AI...")
        
        // Simulasi delay pengiriman network / AI processing selama 2 detik
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            print("Berhasil diproses oleh Backend/AI!")
            self?.isProcessing = false
            
            // Tindakan selanjutnya bisa dilakukan di sini,
            // seperti navigasi ke halaman Result atau menampilkan alert sukses.
        }
    }
}
