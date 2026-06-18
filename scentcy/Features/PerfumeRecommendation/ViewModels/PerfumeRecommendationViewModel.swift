import SwiftUI
import Combine

class PerfumeRecommendationViewModel: ObservableObject {
    @Published var perfumes: [Perfume] = []
    private var allPerfumes: [Perfume] = []
    
    // Filter States
    @Published var selectedLongevities: Set<String> = []
    @Published var selectedSillages: Set<String> = []
    @Published var selectedTimes: Set<String> = []
    @Published var selectedOccasions: Set<String> = []
    
    init() {
        loadDummyData()
    }
    
    private func loadDummyData() {
        if let url = Bundle.main.url(forResource: "perfumes", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([PerfumeCodable].self, from: data) {
            allPerfumes = decoded.map { $0.toPerfume() }
        }
        applyFilter()
    }
    
    func clearFilter() {
        selectedLongevities.removeAll()
        selectedSillages.removeAll()
        selectedTimes.removeAll()
        selectedOccasions.removeAll()
    }
    
    func applyFilter() {
        perfumes = allPerfumes.filter { perfume in
            let perfumeTags = Set(perfume.tags)
            
            let matchesLongevity = selectedLongevities.isEmpty || !selectedLongevities.isDisjoint(with: perfumeTags)
            let matchesSillage = selectedSillages.isEmpty || !selectedSillages.isDisjoint(with: perfumeTags)
            let matchesTime = selectedTimes.isEmpty || !selectedTimes.isDisjoint(with: perfumeTags)
            let matchesOccasion = selectedOccasions.isEmpty || !selectedOccasions.isDisjoint(with: perfumeTags)
            
            return matchesLongevity && matchesSillage && matchesTime && matchesOccasion
        }
    }
}
