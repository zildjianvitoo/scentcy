import Foundation

enum AppError: Error, LocalizedError {
    case networkError
    case invalidResponse
    case custom(String)
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Failed to connect to the network."
        case .invalidResponse:
            return "Received invalid response from the server."
        case .custom(let message):
            return message
        }
    }
}
