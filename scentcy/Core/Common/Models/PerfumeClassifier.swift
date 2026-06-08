//import Foundation
//import CoreML
//import Vision
//import UIKit
//
//class PerfumeClassifier: ObservableObject {
//    @Published var predictionLabel: String = ""
//    @Published var confidence: Float = 0.0
//    
//    // Make sure your model is named exactly like this in Xcode, or update this line.
//    // Xcode auto-generates this class when you drag the .mlmodel file into your project.
//    private var model: VNCoreMLModel?
//    
//    init() {
//        loadModel()
//    }
//    
//    private func loadModel() {
//        do {
//            // "MyPerfume_1" is usually the generated class name if your file is "MyPerfume 1"
//            // You may need to change "MyPerfume_1" to the exact generated class name
//            let configuration = MLModelConfiguration()
//            let coreMLModel = try MyPerfume_1(configuration: configuration)
//            self.model = try VNCoreMLModel(for: coreMLModel.model)
//        } catch {
//            print("Failed to load CoreML model: \(error)")
//        }
//    }
//    
//    func classify(image: UIImage) {
//        guard let model = model else { return }
//        guard let cgImage = image.cgImage else { return }
//        
//        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
//            guard let results = request.results as? [VNClassificationObservation],
//                  let firstResult = results.first else {
//                DispatchQueue.main.async {
//                    self?.predictionLabel = "Could not classify"
//                }
//                return
//            }
//            
//            DispatchQueue.main.async {
//                self?.predictionLabel = firstResult.identifier
//                self?.confidence = firstResult.confidence
//            }
//        }
//        
//        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
//        DispatchQueue.global(qos: .userInitiated).async {
//            do {
//                try handler.perform([request])
//            } catch {
//                print("Failed to perform classification: \(error)")
//            }
//        }
//    }
//}
