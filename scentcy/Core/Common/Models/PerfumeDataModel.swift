//
//  PerfumeDataModel.swift
//  scentcy
//
//  Created by Afra on 07/06/26.
//

import Foundation

struct PerfumeDataModel: Codable, Identifiable, Hashable {
    var id: Self { self }
    let perfumeName: String
    let brand: String
    let year: String
    let topNotes: String
    let middleNotes: String
    let baseNotes: String
    let mainAccords: String
}
