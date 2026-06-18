import Foundation

protocol RecommendationServicing {
    func computeScentProfile(from scannedPerfumes: [Perfume]) -> [String: Double]
    func top5Accords(from scannedPerfumes: [Perfume]) -> [(accord: String, score: Double)]
    func top5Notes(from scannedPerfumes: [Perfume]) -> [(note: String, frequency: Int)]
    func cosineSimilarity(vectorA: [String: Double], vectorB: [String: Double]) -> Double
    func recommendations(allPerfumes: [Perfume], scannedPerfumes: [Perfume]) -> [(perfume: Perfume, similarityScore: Double)]
}

struct RecommendationService: RecommendationServicing {
    
    /// Computes the User's Scent Profile vector based on scanned perfumes.
    /// Returns a dictionary of [AccordName: AggregatedScore]
    func computeScentProfile(from scannedPerfumes: [Perfume]) -> [String: Double] {
        var profile: [String: Double] = [:]
        
        for perfume in scannedPerfumes {
            for (accord, score) in perfume.mainAccords {
                profile[accord, default: 0.0] += score
            }
        }
        
        // Note: For cosine similarity, we don't strictly need to normalize the sum here
        // as the cosine similarity formula handles magnitude, but returning the raw sum works.
        return profile
    }
    
    /// Computes the Top 5 highest weighted Accords from the user's scanned history.
    func top5Accords(from scannedPerfumes: [Perfume]) -> [(accord: String, score: Double)] {
        let profile = computeScentProfile(from: scannedPerfumes)
        let sorted = profile.sorted { $0.value > $1.value }
        return Array(sorted.prefix(5)).map { (accord: $0.key, score: $0.value) }
    }
    
    /// Computes the Top 5 most frequent Notes (combining Top, Middle, Base) from the user's scanned history.
    func top5Notes(from scannedPerfumes: [Perfume]) -> [(note: String, frequency: Int)] {
        var notesFrequency: [String: Int] = [:]
        
        for perfume in scannedPerfumes {
            let allNotes = perfume.topNotes + perfume.middleNotes + perfume.baseNotes
            for note in allNotes {
                notesFrequency[note.lowercased().trimmingCharacters(in: .whitespacesAndNewlines), default: 0] += 1
            }
        }
        
        let sorted = notesFrequency.sorted { $0.value > $1.value }
        return Array(sorted.prefix(5)).map { (note: $0.key, frequency: $0.value) }
    }
    
    /// Calculates Cosine Similarity between two vectors.
    func cosineSimilarity(vectorA: [String: Double], vectorB: [String: Double]) -> Double {
        let intersection = Set(vectorA.keys).intersection(Set(vectorB.keys))
        
        var dotProduct: Double = 0.0
        for key in intersection {
            dotProduct += (vectorA[key] ?? 0.0) * (vectorB[key] ?? 0.0)
        }
        
        let magnitudeA = sqrt(vectorA.values.reduce(0.0) { $0 + ($1 * $1) })
        let magnitudeB = sqrt(vectorB.values.reduce(0.0) { $0 + ($1 * $1) })
        
        if magnitudeA == 0.0 || magnitudeB == 0.0 {
            return 0.0
        }
        
        return dotProduct / (magnitudeA * magnitudeB)
    }
    
    /// Generates a sorted list of recommended perfumes.
    /// Excludes perfumes that have already been scanned.
    func recommendations(allPerfumes: [Perfume], scannedPerfumes: [Perfume]) -> [(perfume: Perfume, similarityScore: Double)] {
        let scentProfile = computeScentProfile(from: scannedPerfumes)
        
        // If no profile exists (nothing scanned yet), return empty or default recommendations
        if scentProfile.isEmpty {
            return []
        }
        
        let scannedIDs = Set(scannedPerfumes.map { $0.id })
        let unscannedPerfumes = allPerfumes.filter { !scannedIDs.contains($0.id) }
        
        var scoredPerfumes: [(perfume: Perfume, similarityScore: Double)] = []
        
        for perfume in unscannedPerfumes {
            let score = cosineSimilarity(vectorA: scentProfile, vectorB: perfume.mainAccords)
            scoredPerfumes.append((perfume: perfume, similarityScore: score))
        }
        
        // Sort descending by similarity score
        scoredPerfumes.sort { $0.similarityScore > $1.similarityScore }
        
        return scoredPerfumes
    }
}
