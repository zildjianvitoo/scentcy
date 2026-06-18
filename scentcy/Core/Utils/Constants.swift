import Foundation

struct Constants {
    struct API {
        static let baseURL = "https://api.scentcy.com/v1"
        static let timeout: TimeInterval = 30.0
    }
    
    struct UI {
        static let defaultPadding: CGFloat = 16.0
        static let screenPadding: CGFloat = 20.0
        static let largePadding: CGFloat = 24.0
        static let cornerRadius: CGFloat = 24.0
        static let smallCornerRadius: CGFloat = 12.0
    }
    
    struct Animation {
        static let defaultDuration: Double = 0.3
        static let springResponse: Double = 0.4
        static let springDamping: Double = 0.7
    }
    
    struct Camera {
        static let reticleSize: CGFloat = 250.0
        static let shutterSize: CGFloat = 72.0
        static let shutterInnerSize: CGFloat = 58.0
        static let maxPhotosBeforeFatigue: Int = 4
    }
}
