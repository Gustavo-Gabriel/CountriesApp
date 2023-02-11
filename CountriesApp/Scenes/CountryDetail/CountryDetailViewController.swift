import UIKit

final class CountryDetailViewController: UIViewController {
    private var country: Country
    private let countryDetailView = CountryDetailView()

    init(country: Country) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        countryDetailView.updateUI(with: country)
    }

    private func setupUI() {
        countryDetailView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(countryDetailView)

        countryDetailView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        countryDetailView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        countryDetailView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        countryDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupNavBar() {
        title = country.name.common
    }
}
