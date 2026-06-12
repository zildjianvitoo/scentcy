import Foundation
import SwiftData

@Model
class Perfume {
    @Attribute(.unique) var id = UUID()
    var name: String
    var brand: String
    
    var year: String?
    var topNotes: String?
    var middleNotes: String?
    var baseNotes: String?
    var mainAccords: [String]
    
    var imageName: String
    var tags: [String]
    
    var isFavorite: Bool
    
    init(
        name: String,
        brand: String,
        year: String? = nil,
        topNotes: String? = nil,
        middleNotes: String? = nil,
        baseNotes: String? = nil,
        mainAccords: [String] = [],
        imageName: String = "",
        tags: [String] = [],
        isFavorite: Bool = false
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
        self.isFavorite = isFavorite
    }
}
