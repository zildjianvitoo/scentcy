import Foundation
import CoreML
import Vision
import UIKit
import Combine
import SwiftUI // ObservableObject is part of Combine/SwiftUI

class PerfumeClassifier: ObservableObject {
    @Published var predictionLabel: String = ""
    @Published var confidence: Float = 0.0
    @Published var isClassifying: Bool = false
    
    private var model: VNCoreMLModel?
    
    init() {
        loadModel()
    }
    
    private func loadModel() {
        do {
            let configuration = MLModelConfiguration()
            let coreMLModel = try PerfumeClasifier(configuration: configuration)
            self.model = try VNCoreMLModel(for: coreMLModel.model)
        } catch {
            print("Failed to load CoreML model: \(error)")
        }
    }
    
    func classify(image: UIImage) {
        guard let model = model else { return }
        guard let cgImage = image.cgImage else { return }
        
        DispatchQueue.main.async {
            self.isClassifying = true
        }
        
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            defer {
                DispatchQueue.main.async {
                    self?.isClassifying = false
                }
            }
            
            guard let results = request.results as? [VNClassificationObservation],
                  let firstResult = results.first else {
                DispatchQueue.main.async {
                    self?.predictionLabel = "Could not classify"
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.predictionLabel = firstResult.identifier
                self?.confidence = firstResult.confidence
            }
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform classification: \(error)")
                DispatchQueue.main.async {
                    self.isClassifying = false
                }
            }
        }
    }
}
