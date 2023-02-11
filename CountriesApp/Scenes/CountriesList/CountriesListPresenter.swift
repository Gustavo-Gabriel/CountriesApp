final class CountriesListPresenter: CountriesListPresenterType {
    weak var controller: CountriesListViewControllerType?

    private var state: CountriesListState = .loading {
        didSet {
            controller?.show(state: state)
        }
    }

    private let repository = CountriesListRepository(network: Network.shared)

    func requestCountries() {
        state = .loading

        repository.requestList { [weak self] result in
            switch result {
            case .success(let countries):
                self?.handleSucess(countries: countries)
            case .failure:
                self?.state = .error
            }
        }
    }

    private func handleSucess(countries: [Country]) {
        let sortedCountries = countries.sorted(by: { $0.name.official < $1.name.official } )
        state = .ready(countries: sortedCountries)
    }
}
