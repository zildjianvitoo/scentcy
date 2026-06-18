import SwiftUI
import Combine
import AVFoundation
import SwiftData

enum CameraActiveSheet: Identifiable {
    case confirmation
    case notFound
    case manualInput
    
    var id: Int {
        switch self {
        case .confirmation: return 1
        case .notFound: return 2
        case .manualInput: return 3
        }
    }
}

class CameraViewModel: ObservableObject {
    @Published var session: AVCaptureSession = AVCaptureSession()
    @Published var isCameraGranted: Bool = false
    @Published var capturedImage: UIImage?
    @Published var isProcessing: Bool = false
    @Published var isShowingResultSheet: Bool = false
    @Published var activeSheet: CameraActiveSheet?
    @Published var isShowingNoseFatigueAlert: Bool = false
    @Published var photoCaptureCount: Int = 0
    @Published var matchedPerfume: Perfume?
    
    private let cameraService: CameraServicing
    let classifier = PerfumeClassifier()
    private var cancellables = Set<AnyCancellable>()
    
    var dbPerfumes: [Perfume] = []
    
    init(cameraService: CameraServicing = CameraService()) {
        self.cameraService = cameraService
        self.session = cameraService.session
        
        // Observe permission
        cameraService.isGrantedPublisher
            .assign(to: \.isCameraGranted, on: self)
            .store(in: &cancellables)
            
        // Observe captured image
        cameraService.onImageCaptured = { [weak self] image in
            self?.capturedImage = image
            self?.photoCaptureCount += 1
            self?.processImage(image)
        }
        
        // Observe classifier results
        classifier.$predictionLabel
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] label in
                guard let self = self else { return }
                self.isProcessing = false
                
                if label == "Not Found" || label == "Could not classify" {
                    print("ML Mapping Log: Skipped mapping because label is '\(label)'")
                    self.activeSheet = .notFound
                } else {
                    // Try to map to actual perfume
                    let sanitizedLabel = label.lowercased().components(separatedBy: .alphanumerics.inverted).joined()
                    print("ML Mapping Log: Raw Label = '\(label)', Sanitized = '\(sanitizedLabel)'")
                    
                    if let foundPerfume = self.dbPerfumes.first(where: { 
                        let sanitizedName = $0.name.lowercased().components(separatedBy: .alphanumerics.inverted).joined()
                        let sanitizedMlIdentifier = ($0.mlIdentifier ?? "").lowercased().components(separatedBy: .alphanumerics.inverted).joined()
                        return sanitizedName == sanitizedLabel || (!sanitizedMlIdentifier.isEmpty && sanitizedMlIdentifier == sanitizedLabel)
                    }) {
                        print("ML Mapping Log: Match Found in Database -> '\(foundPerfume.name)'")
                        self.matchedPerfume = foundPerfume
                        self.activeSheet = .confirmation
                    } else {
                        print("ML Mapping Log: NO MATCH FOUND in database for sanitized label '\(sanitizedLabel)'")
                        // If somehow predicted but not in database
                        self.activeSheet = .notFound
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func capturePhoto() {
        cameraService.capturePhoto()
    }
    
    func startCamera() {
        cameraService.startSession()
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
            self.isProcessing = true
            classifier.classify(image: image)
        }
    }
    
    func markPerfumeAsScanned(_ perfume: Perfume, context: ModelContext) {
        perfume.isScanned = true
        perfume.scannedAt = Date()
        try? context.save()
    }
}
