protocol CountriesListViewType: AnyObject {
    func updateViewState(_ state: CountriesListState)
    func setDelegate(_ delegate: CountriesListViewDelegate?)
}

protocol CountriesListViewControllerType: AnyObject {
    func updateViewState(_ state: CountriesListState)
}

protocol CountriesListRepositoryType {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void)
}

protocol CountriesListPresenterType {
    func fetchCountries()
    func refreshCountries()
}

protocol CountriesListViewDelegate: AnyObject {
    func didPullToRefresh()
    func didSelectCountry(_ country: Country)
}
