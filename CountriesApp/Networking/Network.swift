import Foundation

final class Network: NetworkType {
    static let shared = Network()

    private init() { }

    func execute<T: Codable>(_ service: ServiceType, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let request = Request(service: service)

        guard let urlRequest = request.buildURL() else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }

            do {
                let result = try JSONDecoder().decode(type, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
