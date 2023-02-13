struct Country: Codable {
    let name: CountryName
    let flag: String
    let translations: [String: Translation]
}

struct CountryName: Codable {
    let common: String
    let official: String
}
