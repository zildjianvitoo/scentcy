import SwiftUI
import Observation

@Observable
class JourneyViewModel {
    var sniffedPerfumes: [Perfume] = []
    var savedPerfumes: [Perfume] = []
    
    func update(with allPerfumes: [Perfume]) {
        self.sniffedPerfumes = allPerfumes.filter { $0.isScanned }.sorted(by: { 
            ($0.scannedAt ?? Date.distantPast) > ($1.scannedAt ?? Date.distantPast) 
        })
        self.savedPerfumes = allPerfumes.filter { $0.isFavorite }
    }
}
