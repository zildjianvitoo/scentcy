import SwiftUI

extension Color {
    // Dynamic Colors based on user interface style
    static let appPrimary = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "B3976B") : UIColor(hex: "F0D9BA")
    })
    
    static let appSecondary = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "4D6C8F") : UIColor(hex: "7FA7D1")
    })
    
    static let appBackground = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "1C1C1E") : UIColor(hex: "FDF8F2")
    })
    
    static let textGray = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "A0A0A5") : UIColor(hex: "979699")
    })
    
    static let babyBlue = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "345A7D") : UIColor(hex: "CEE4F6")
    })
    
    static let appGray = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "2C2C2E") : UIColor(hex: "E3E3E3")
    })
    
    static let appButton = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "D19B4C") : UIColor(hex: "E1B376")
    })
    
    static let appCardBackground = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "2C2C2E") : UIColor(hex: "F7F3EE")
    })
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 1)
        }

        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue:  CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 1)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
