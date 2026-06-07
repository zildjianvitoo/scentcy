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
        allPerfumes = [
            Perfume(name: "Eau Capitale", brand: "Diptyque", imageName: "goodgirl", tags: ["Eternal", "Moderate", "Day", "Casual"]),
            Perfume(name: "Libre", brand: "Yves Saint Laurent", imageName: "goodgirl", tags: ["Long Lasting", "Strong", "Night", "Formal"]),
            Perfume(name: "Baccarat Rouge 540", brand: "Maison Francis Kurkdjian", imageName: "goodgirl", tags: ["Eternal", "Enormous", "Night", "Formal"]),
            Perfume(name: "Wood Sage & Sea Salt", brand: "Jo Malone", imageName: "goodgirl", tags: ["Weak", "Intimate", "Day", "Informal"])
        ]
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
