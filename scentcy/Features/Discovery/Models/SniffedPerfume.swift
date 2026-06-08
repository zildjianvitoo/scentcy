//
//  SniffedPerfume.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import Foundation

struct SniffedPerfume: Identifiable {
    let id = UUID()
    let perfumeName: String
    let brandName: String
    let tags: [String]
    let imageName: String
}

// MARK: - Dummy Data
extension SniffedPerfume {
    static let dummySample = SniffedPerfume(
        perfumeName: "Le Male",
        brandName: "Jean Paul Gaultier",
        tags: ["Night", "Formal"],
        imageName: "lemale"
    )
}
