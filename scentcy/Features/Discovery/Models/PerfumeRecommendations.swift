//
//  PerfumeRecommendations.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import Foundation

struct PerfumeRecommendation: Identifiable {
    let id: UUID = UUID()
    let name: String
    let brand: String
    let imageName: String
}

// MARK: - Dummy Data
extension PerfumeRecommendation {
    static let dummySamples: [PerfumeRecommendation] = [
        PerfumeRecommendation(name: "Bleu de Chanel", brand: "Chanel", imageName: ""),
        PerfumeRecommendation(name: "Sauvage", brand: "Dior", imageName: ""),
        PerfumeRecommendation(name: "Black Opium", brand: "YSL", imageName: "")
    ]
}

