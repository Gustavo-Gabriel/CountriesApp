import Foundation

final class Request: RequestType {
    private let baseURL = "https://restcountries.com/"
    private let APIVersion = "v3.1/"
    private let service: ServiceType

    init(service: ServiceType) {
        self.service = service
    }

    func buildURL() -> URLRequest? {
        let string = "\(baseURL)\(APIVersion)\(service.path)"

        guard let urlString = URL(string: string) else {
            return nil
        }

        var urlRequest = URLRequest(url: urlString)
        urlRequest.httpMethod = service.httpMethod.rawValue
        return urlRequest
    }
}
