import UIKit

final class CountryDetailViewController: UIViewController {
    private let country: CountryModel
    private let countryDetailView: CountryDetailView

    init(country: CountryModel,
         countryDetailView: CountryDetailView = CountryDetailView()) {
        self.country = country
        self.countryDetailView = countryDetailView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        countryDetailView.show(country: country)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupUI() {
        countryDetailView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(countryDetailView)

        countryDetailView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        countryDetailView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        countryDetailView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        countryDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
