import Foundation

enum AppError: Error, LocalizedError {
    case networkError
    case invalidResponse
    case custom(String)
    case cameraPermissionDenied
    case cameraSetupFailed
    case modelLoadFailed
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Failed to connect to the network."
        case .invalidResponse:
            return "Received invalid response from the server."
        case .custom(let message):
            return message
        case .cameraPermissionDenied:
            return "Camera permission is required to scan perfumes."
        case .cameraSetupFailed:
            return "Failed to setup camera."
        case .modelLoadFailed:
            return "Failed to load the prediction model."
        }
    }
}
