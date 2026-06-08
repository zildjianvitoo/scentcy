import Foundation

struct Perfume: Codable, Identifiable, Hashable {
    var id = UUID()
    let name: String
    let brand: String
    
    let year: String?
    let topNotes: String?
    let middleNotes: String?
    let baseNotes: String?
    let mainAccords: String?
    
    let imageName: String
    let tags: [String]
    
    init(
        name: String,
        brand: String,
        year: String? = nil,
        topNotes: String? = nil,
        middleNotes: String? = nil,
        baseNotes: String? = nil,
        mainAccords: String? = nil,
        imageName: String = "",
        tags: [String] = []
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
    }
}
