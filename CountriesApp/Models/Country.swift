struct Country: Codable {
    let name: CountryName
}

struct CountryName: Codable {
    let common: String
    let official: String
}
