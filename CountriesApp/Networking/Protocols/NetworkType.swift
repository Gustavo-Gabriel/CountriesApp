protocol NetworkType {
    func execute<T: Codable>(_ service: ServiceType, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}
