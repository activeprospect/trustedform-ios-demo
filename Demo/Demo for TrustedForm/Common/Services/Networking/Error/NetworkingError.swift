import protocol Foundation.LocalizedError

enum NetworkingError: LocalizedError {
    case custom(message: String)
    case failedDecoding
    case unknown
    
    var errorDescription: String? {
        switch self {
        case let .custom(message: message):
            return message
        case .failedDecoding:
            return "NETWORKING_ERROR_DECODING".localized
        case .unknown:
            return "NETWORKING_ERROR_UNKNOWN".localized
        }
    }
}
