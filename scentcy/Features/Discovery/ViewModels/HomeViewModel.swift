import SwiftUI
import Observation

@Observable
class HomeViewModel {
    var previouslySniffed: Perfume?
    var recommendedPerfumes: [Perfume] = []
    
    var vibeName: String = "Woody"
    var vibeIcon: String = "tree"
    var aromaNotes: [String] = ["Mandarin Orange", "Cedar", "Amber", "Orange", "Batam Orange"]
    
    func update(with allPerfumes: [Perfume]) {
        let sniffedPerfumes = allPerfumes.filter { $0.isScanned }
        
        // Latest sniffed or just the first one found
        self.previouslySniffed = sniffedPerfumes.last
        
        // Similar perfumes using Cosine Similarity
        let recommendations = RecommendationService.getRecommendations(
            allPerfumes: allPerfumes,
            scannedPerfumes: sniffedPerfumes
        )
        
        // Take top 4 recommendations
        self.recommendedPerfumes = recommendations.prefix(4).map { $0.perfume }
        
        // Compute Vibe dynamic values
        if !sniffedPerfumes.isEmpty {
            let topAccords = RecommendationService.getTop5Accords(from: sniffedPerfumes)
            if let topAccord = topAccords.first?.accord {
                self.vibeName = topAccord
                self.vibeIcon = self.iconForAccord(topAccord)
            }
            
            let topNotes = RecommendationService.getTop5Notes(from: sniffedPerfumes)
            if !topNotes.isEmpty {
                self.aromaNotes = topNotes.map { $0.note.capitalized }
            }
        } else {
            // Defaults when empty
            self.vibeName = "Woody"
            self.vibeIcon = "tree"
            self.aromaNotes = ["Mandarin Orange", "Cedar", "Amber", "Orange", "Batam Orange"]
        }
    }
    
    private func iconForAccord(_ accord: String) -> String {
        let normalized = accord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        switch normalized {
        case let x where x.contains("wood"):
            return "tree"
        case let x where x.contains("floral") || x.contains("rose") || x.contains("violet") || x.contains("iris"):
            return "flower.fill"
        case let x where x.contains("fresh") || x.contains("aquatic") || x.contains("ozonic") || x.contains("water") || x.contains("marine"):
            return "wind"
        case let x where x.contains("citrus") || x.contains("fruit") || x.contains("green") || x.contains("herbal"):
            return "leaf.fill"
        case let x where x.contains("spicy") || x.contains("warm"):
            return "flame.fill"
        case let x where x.contains("amber") || x.contains("sweet") || x.contains("vanilla") || x.contains("caramel") || x.contains("powdery"):
            return "sparkles"
        default:
            return "sparkles"
        }
    }
}
