import Foundation

struct Perfume: Identifiable {
    let id = UUID()
    let name: String
    let brand: String
    let imageName: String
    let tags: [String]
}
