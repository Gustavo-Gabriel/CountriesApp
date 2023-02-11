import UIKit

protocol CountriesListDataSourceDelegate: AnyObject {
    func didSelectCountry(_ country: Country)
}

final class CountriesListDataSource: NSObject {
    weak var delegate: CountriesListDataSourceDelegate?

    private var countries: [Country] = []

    func updateItems(_ countries: [Country]) {
        self.countries = countries
    }
}

extension CountriesListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = countries[safe: indexPath.row]?.name.official
        return cell
    }
}

extension CountriesListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = countries[indexPath.row]
        delegate?.didSelectCountry(selectedCountry)
    }
}
