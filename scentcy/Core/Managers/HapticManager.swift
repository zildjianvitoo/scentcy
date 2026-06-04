import SwiftUI

class HapticManager {
    static let shared = HapticManager()
    
    private init() {}
    
    func playImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
