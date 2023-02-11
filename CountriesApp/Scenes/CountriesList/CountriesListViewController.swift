import UIKit

final class CountriesListViewController: UIViewController {
    private let presenter = CountriesListPresenter()
    private let countriesListView = CountriesListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        countriesListView.delegate = self
        presenter.controller = self
        presenter.fetchCountries()
    }

    private func setupUI() {
        countriesListView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(countriesListView)

        countriesListView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        countriesListView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        countriesListView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        countriesListView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        setupNavBar()
    }

    private func setupNavBar() {
        title = "Countries"
    }
}

extension CountriesListViewController: CountriesListViewControllerType {
    func updateViewState(_ state: CountriesListState) {
        countriesListView.updateViewState(state)
    }
}

extension CountriesListViewController: CountriesListViewDelegate {
    func didPullToRefresh() {
        presenter.refreshCountries()
    }
}
