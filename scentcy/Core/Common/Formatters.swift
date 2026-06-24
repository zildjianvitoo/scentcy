import Foundation

func formatLongevity(_ raw: String) -> String {
    switch raw {
    case "Very Weak": return "3 hour"
    case "Weak": return "4 hour"
    case "Moderate": return "5 hour"
    case "Long Lasting": return "8 hour"
    case "Eternal": return "9 hour"
    default: return raw
    }
}
