import Foundation

final class CountriesListPresenter: CountriesListPresenterType {
    weak var controller: CountriesListViewControllerType?

    private var state: CountriesListState = .loading {
        didSet {
            controller?.updateViewState(state)
        }
    }

    private let repository = CountriesListRepository(network: Network.shared)
    private let adapter = CountriesListAdapter()

    func fetchCountries() {
        state = .loading

        repository.fetchCountries { [weak self] result in
            switch result {
            case .success(let countries):
                self?.handleSucess(countries: countries)
            case .failure:
                self?.state = .error
            }
        }
    }

    func refreshCountries() {
        fetchCountries()
    }

    private func handleSucess(countries: [Country]) {
        let countryModel = adapter.adapt(countries)
        let sortedCountries = countryModel.sorted(by: { $0.nameCommon < $1.nameCommon } )

        state = .ready(countries: sortedCountries)
    }
}
