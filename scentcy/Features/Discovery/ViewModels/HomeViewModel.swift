import SwiftUI
import Observation

@Observable
class HomeViewModel {
    var previouslySniffed: Perfume?
    var recommendedPerfumes: [Perfume] = []
    
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
    }
}
