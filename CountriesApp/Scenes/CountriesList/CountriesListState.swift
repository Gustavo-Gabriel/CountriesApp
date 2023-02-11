enum CountriesListState {
    case ready(countries: [Country])
    case loading
    case error
}
