import Foundation

protocol RequestType {
    func buildURL() -> URLRequest?
}
