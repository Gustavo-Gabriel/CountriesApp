enum CountriesListState {
    case ready(countries: [CountryModel])
    case loading
    case error
}
