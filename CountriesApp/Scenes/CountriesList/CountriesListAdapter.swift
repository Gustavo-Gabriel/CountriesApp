import Foundation

final class CountriesListAdapter: CountriesListAdapterType {
    func adapt(_ countries: [Country]) -> [CountryModel] {
        let countryModel = countries.map {
            if let currentLanguageCode = Locale.current.languageCode,
               let languageCode = LanguageMapping.languages[currentLanguageCode],
               let translation = $0.translations[languageCode] {
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
