//
//  PerfumeCardData.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import Foundation

struct PerfumeCardData: Identifiable {
    let id = UUID()
    let name: String
    let brand: String
    let imageName: String
}

// MARK: - Dummy Data
extension PerfumeCardData {
    static let dummySamples: [PerfumeCardData] = [
        PerfumeCardData(name: "Eau Capitale", brand: "Diptyque",           imageName: "eaucapitale"),
        PerfumeCardData(name: "Libre",        brand: "Yves Saint Laurent", imageName: "libre"),
        PerfumeCardData(name: "Rose",         brand: "La Labo",            imageName: "rose"),
        PerfumeCardData(name: "Baccarat 540", brand: "Maison Margiela",    imageName: "baccarat"),
    ]
}
