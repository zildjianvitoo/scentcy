import SwiftUI
import Observation

@Observable
class HomeViewModel {
    var previouslySniffed: Perfume?
    var recommendedPerfumes: [Perfume] = []
    
    var vibeName: String = "Discovering"
    var vibeIcon: String = "sparkles"
    var aromaNotes: [String] = []
    
    // You can also expose Scent Profile Top Notes/Accords if needed by ScentProfileCard
    // For now we just compute the data needed by HomeView
    
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
        
        // Calculate Vibe
        var accordScores: [String: Double] = [:]
        var noteCounts: [String: Int] = [:]
        
        for perfume in sniffedPerfumes {
            // Aggregate accords
            for (accord, score) in perfume.mainAccords {
                accordScores[accord, default: 0.0] += score
            }
            
            // Aggregate notes
            let allNotes = perfume.topNotes + perfume.middleNotes + perfume.baseNotes
            for note in allNotes {
                noteCounts[note, default: 0] += 1
            }
        }
        
        // Get Top Accord
        if let topAccord = accordScores.max(by: { $0.value < $1.value })?.key {
            self.vibeName = topAccord.capitalized
            self.vibeIcon = iconForAccord(topAccord)
        } else {
            self.vibeName = "Discovering"
            self.vibeIcon = "sparkles"
        }
        
        // Get Top 5 Notes
        let sortedNotes = noteCounts.sorted { $0.value > $1.value }
        self.aromaNotes = sortedNotes.prefix(5).map { $0.key }
    }
    
    private func iconForAccord(_ accord: String) -> String {
        let lower = accord.lowercased()
        if lower.contains("wood") { return "tree" }
        if lower.contains("citrus") { return "sun.max" }
        if lower.contains("floral") || lower.contains("white floral") { return "leaf" }
        if lower.contains("fresh") || lower.contains("aquatic") { return "drop" }
        if lower.contains("sweet") || lower.contains("vanilla") { return "heart" }
        if lower.contains("spicy") || lower.contains("warm") { return "flame" }
        if lower.contains("earthy") || lower.contains("patchouli") { return "globe.americas" }
        if lower.contains("powdery") || lower.contains("musk") { return "wind" }
        if lower.contains("aromatic") || lower.contains("green") { return "leaf" }
        if lower.contains("leather") { return "bag" }
        return "sparkles"
    }
}
