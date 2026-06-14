import SwiftUI
import Observation

@Observable
class JourneyViewModel {
    var sniffedPerfumes: [Perfume] = []
    var savedPerfumes: [Perfume] = []
    
    func update(with allPerfumes: [Perfume]) {
        self.sniffedPerfumes = allPerfumes.filter { $0.isScanned }
        self.savedPerfumes = allPerfumes.filter { $0.isFavorite }
    }
}
