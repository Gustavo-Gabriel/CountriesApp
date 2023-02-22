import Foundation

protocol ServiceType {
    var path: String { get }
    var pathComponents: [String] { get }
    var queryParameters: [URLQueryItem] { get }
    var httpMethod: HTTPMethod { get }
}
