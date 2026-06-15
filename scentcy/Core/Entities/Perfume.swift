import Foundation
import SwiftData

@Model
class Perfume {
    @Attribute(.unique) var id = UUID()
    var name: String
    var brand: String
    
    var year: String?
    var topNotes: [String]
    var middleNotes: [String]
    var baseNotes: [String]
    var mainAccords: [String: Double]
    
    var imageName: String
    var tags: [String]
    var mlIdentifier: String?
    
    var isFavorite: Bool
    var isScanned: Bool
    var scannedAt: Date?
    
    init(
        name: String,
        brand: String,
        year: String? = nil,
        topNotes: [String] = [],
        middleNotes: [String] = [],
        baseNotes: [String] = [],
        mainAccords: [String: Double] = [:],
        imageName: String = "",
        tags: [String] = [],
        mlIdentifier: String? = nil,
        isFavorite: Bool = false,
        isScanned: Bool = false,
        scannedAt: Date? = nil
    ) {
        self.name = name
        self.brand = brand
        self.year = year
        self.topNotes = topNotes
        self.middleNotes = middleNotes
        self.baseNotes = baseNotes
        self.mainAccords = mainAccords
        self.imageName = imageName
        self.tags = tags
        self.mlIdentifier = mlIdentifier
        self.isFavorite = isFavorite
        self.isScanned = isScanned
        self.scannedAt = scannedAt
    }
}
