import Foundation

protocol CountriesListAdapterType {
    func adapt(_ countries: [Country]) -> [CountryModel]
}

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

final class CountriesListAdapter: CountriesListAdapterType {
    func adapt(_ countries: [Country]) -> [CountryModel] {
        let countryModel = countries.map {
            if let currentLanguageCode = Locale.current.languageCode,
               let languageCode = LanguageMapping.languages[currentLanguageCode],
               let translation = $0.translations[languageCode] {
                print("O Pai: \(translation.common)")
                return CountryModel(nameCommon: translation.common,
                                    nameOfficial: translation.official,
                                    flag: $0.flag,
                                    population: $0.population)
            }

            return CountryModel(nameCommon: $0.name.common,
                                nameOfficial: $0.name.common,
                                flag: $0.flag,
                                population: $0.population)
        }

        return countryModel
    }
}
