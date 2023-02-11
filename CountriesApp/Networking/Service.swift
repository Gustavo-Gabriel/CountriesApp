import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}

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
