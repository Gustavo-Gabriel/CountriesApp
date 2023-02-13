import UIKit

protocol CountriesListDataSourceDelegate: AnyObject {
    func didSelectCountry(_ country: CountryModel)
}

final class CountriesListDataSource: NSObject {
    weak var delegate: CountriesListDataSourceDelegate?

    private var countries: [CountryModel] = []

    func updateItems(_ countries: [CountryModel]) {
        self.countries = countries
    }
}

extension CountriesListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = countries[safe: indexPath.row]?.nameCommon
        return cell
    }
}

extension CountriesListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = countries[indexPath.row]
        delegate?.didSelectCountry(selectedCountry)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
