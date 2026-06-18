//
//  PerfumeDetailViewModel.swift
//  scentcy
//
//  Created by Antigravity
//

import SwiftUI
import SwiftData

@Observable
class PerfumeDetailViewModel {
    var perfume: Perfume
    
    init(perfume: Perfume) {
        self.perfume = perfume
    }
    
    var scentNotes: [String] {
        let sorted = perfume.mainAccords.sorted { $0.value > $1.value }
        return sorted.prefix(2).map { $0.key.capitalized }
    }
    
    var longevity: String {
        let options = ["Eternal", "Long Lasting", "Moderate", "Weak", "Very Weak"]
        return perfume.tags.first(where: { options.contains($0) }) ?? "Moderate"
    }
    
    var sillage: String {
        let options = ["Intimate", "Moderate", "Strong", "Enormous"]
        return perfume.tags.last(where: { options.contains($0) }) ?? "Moderate"
    }
    
    var time: String {
        let hasDay = perfume.tags.contains("Day")
        let hasNight = perfume.tags.contains("Night")
        if hasDay && hasNight { return "Day & Night" }
        if hasDay { return "Day" }
        if hasNight { return "Night" }
        return "Day & Night"
    }
    
    var occasion: String {
        let options = ["Formal", "Casual", "Informal"]
        return perfume.tags.first(where: { options.contains($0) }) ?? "Casual"
    }
    
    var notes: [String] {
        let allNotes = perfume.topNotes + perfume.middleNotes + perfume.baseNotes
        return allNotes.map { $0.capitalized }
    }
    
    var isFavorite: Bool {
        return perfume.isFavorite
    }
    
    func toggleFavorite() {
        perfume.isFavorite.toggle()
    }
}
