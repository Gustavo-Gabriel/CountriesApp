import Foundation

enum Service: ServiceType {
    case all

    var path: String {
        switch self {
        case .all:
            return "all"
        }
    }
    
    var pathComponents: [String] {
        switch self {
        case .all:
            return []
        }
    }
    
    var queryParameters: [URLQueryItem] {
        switch self {
        case .all:
            return []
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }
}
