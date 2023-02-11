import UIKit

final class CountriesListDataSource: NSObject, UITableViewDataSource {
    private var countries: [Country] = []

    func updateItems(_ countries: [Country]) {
        self.countries = countries
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = countries[safe: indexPath.row]?.name.official
        return cell
    }
}