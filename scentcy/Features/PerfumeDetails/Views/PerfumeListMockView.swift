//
//  PerfumeListMockView.swift
//  scentcy
//
//  Created by Afra on 07/06/26.
//

import SwiftUI

struct PerfumeListMockView: View {
    var capturedImage: UIImage?
    
    @StateObject private var classifier = PerfumeClassifier()
    @State private var selectedPerfume: Perfume?

    private func sanitize(_ name: String) -> String {
        name.lowercased().components(separatedBy: .alphanumerics.inverted).joined()
    }

    var matchedPerfume: PerfumeDataModel? {
        perfumeDataArray.first { sanitize($0.perfumeName) == sanitize(classifier.predictionLabel) }
    }

    var body: some View {
    //    ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                
                // 1. ML Classification Result
                VStack(spacing: 16) {
                    if classifier.isClassifying {
                        ProgressView("Analyzing Scent...")
                            .padding()
                    } else if let perfume = matchedPerfume {
                        VStack(spacing: 8) {
                            Text("We found a match!")
                                .font(.headline)
                            Text("Confidence: \(String(format: "%.0f%%", classifier.confidence * 100))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top)
                        
                        ProductCardGrid(
                            name: perfume.perfumeName,
                            icon: perfume.perfumeName,
                            brand: perfume.brand
                        )
                        .onTapGesture {
                            selectedPerfume = perfume
                        }
                    } else if !classifier.predictionLabel.isEmpty {
                        Text("Could not find a match for: \(classifier.predictionLabel)")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                
                Divider()
                    .padding(.horizontal)
                
                // 2. Original Horizontal List
                VStack(alignment: .leading, spacing: 16) {
                    Text("All Perfumes")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(perfumeDataArray) { perfume in
                                ProductCardGrid(
                                    name: perfume.perfumeName,
                                    icon: perfume.perfumeName,
                                    brand: perfume.brand
                                )
                                .onTapGesture {
                                    selectedPerfume = perfume
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
            .onAppear {
                if let image = capturedImage {
                    classifier.classify(image: image)
                }
            }
            .sheet(item: $selectedPerfume) { perfume in
                PerfumeDetailView(icon: perfume.perfumeName, productName: perfume.perfumeName, brand: perfume.brand)
            }
        }        
        }
     
//}

#Preview {
    PerfumeListMockView(capturedImage: nil)
}
