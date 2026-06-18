import AVFoundation
import UIKit
import Combine

protocol CameraServicing: AnyObject {
    var session: AVCaptureSession { get }
    var isGrantedPublisher: Published<Bool>.Publisher { get }
    var onImageCaptured: ((UIImage) -> Void)? { get set }
    func startSession()
    func stopSession()
    func capturePhoto()
}

class CameraService: NSObject, ObservableObject, CameraServicing {
    var session = AVCaptureSession()
    
    var isGrantedPublisher: Published<Bool>.Publisher { $isGranted }
    
    @Published var isGranted = false
    @Published var capturedImage: UIImage?
    
    private var output = AVCapturePhotoOutput()
    
    // Callback to pass the captured image back to ViewModel
    var onImageCaptured: ((UIImage) -> Void)?
    
    override init() {
        super.init()
        checkPermissions()
    }
    
    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isGranted = true
            setupCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    self?.isGranted = granted
                    if granted {
                        self?.setupCamera()
                    }
                }
            }
        default:
            isGranted = false
        }
    }
    
    func setupCamera() {
        guard isGranted else { return }
        
        session.beginConfiguration()
        
        // Add Input
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: device) else {
            session.commitConfiguration()
            return
        }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        // Add Output
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        
        session.commitConfiguration()
        
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
        }
    }
    
    func capturePhoto() {
        guard session.outputs.contains(output) else {
            print("Camera Output not attached. If you are on a Simulator, providing a dummy image.")
            // Simulator fallback
            if let dummyImage = UIImage(named: "goodgirl1") ?? UIImage(systemName: "photo") {
                DispatchQueue.main.async {
                    self.capturedImage = dummyImage
                    self.onImageCaptured?(dummyImage)
                }
            }
            return
        }
        
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func startSession() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            if !self.session.isRunning {
                self.session.startRunning()
            }
        }
    }
    
    func stopSession() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            if self.session.isRunning {
                self.session.stopRunning()
            }
        }
    }
}

extension CameraService: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error.localizedDescription)")
            return
        }
        
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            return
        }
        
        DispatchQueue.main.async {
            self.capturedImage = image
            self.onImageCaptured?(image)
        }
    }
}
