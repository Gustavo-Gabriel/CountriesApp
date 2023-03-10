final class CountriesListRepository: CountriesListRepositoryType {
    private let network: NetworkType

    init(network: NetworkType) {
        self.network = network
    }

    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        network.execute(Service.all, type: [Country].self, completion: completion)
    }
}
