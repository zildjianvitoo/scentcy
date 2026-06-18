import Foundation

struct PerfumeCodable: Codable {
    var name: String
    var brand: String
    var year: String?
    var topNotes: [String]?
    var middleNotes: [String]?
    var baseNotes: [String]?
    var mainAccords: [String: Double]?
    var imageName: String?
    var tags: [String]?
    var mlIdentifier: String?
    
    func toPerfume() -> Perfume {
        return Perfume(
            name: self.name,
            brand: self.brand,
            year: self.year,
            topNotes: self.topNotes ?? [],
            middleNotes: self.middleNotes ?? [],
            baseNotes: self.baseNotes ?? [],
            mainAccords: self.mainAccords ?? [:],
            imageName: self.imageName ?? "",
            tags: self.tags ?? [],
            mlIdentifier: self.mlIdentifier
        )
    }
}
