protocol CountriesListViewType {
    func show(state: CountriesListState)
}

protocol CountriesListViewControllerType: AnyObject {
    func show(state: CountriesListState)
}

protocol CountriesListRepositoryType {
    func requestList(completion: @escaping (Result<[Country], Error>) -> Void)
}

protocol CountriesListPresenterType {
    func requestCountries()
}
