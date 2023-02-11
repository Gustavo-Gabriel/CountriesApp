struct Country: Codable {
    let name: CountryName
    let flag: String
}

struct CountryName: Codable {
    let common: String
    let official: String
}
