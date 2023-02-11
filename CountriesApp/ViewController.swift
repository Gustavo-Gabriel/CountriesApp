import UIKit
import Foundation

protocol CountriesListViewControllerType: AnyObject {
    func show(state: CountriesListState)
}

final class CountriesListViewController: UIViewController {
    private let presenter = CountriesListPresenter()
    private let countriesListView = CountriesListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.controller = self
        presenter.requestCountries()
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
    func show(state: CountriesListState) {
        countriesListView.show(state: state)
    }
}

enum CountriesListState {
    case ready(countries: [Country])
    case loading
    case error
}

protocol CountriesListViewType {
    func show(state: CountriesListState)
}

final class CountriesListView: UIView {
    private let dataSource = CountriesListDataSource()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.backgroundColor = .systemBackground
        return tableView
    }()

    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.color = .gray
        activityIndicatorView.isHidden = true
        return activityIndicatorView
    }()

    private let errorLabel: UILabel = {
        let errorMessageLabel = UILabel()
        errorMessageLabel.text = "Erro ao carregar os dados"
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.isHidden = true
        return errorMessageLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        tableView.dataSource = dataSource
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .systemBackground

        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tableView)
        addSubview(activityIndicatorView)
        addSubview(errorLabel)
        
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    private func setupReady(_ countries: [Country]) {
        dataSource.updateItems(countries)

        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.activityIndicatorView.isHidden = true
            self.errorLabel.isHidden = true
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        }
    }

    private func setupLoading() {
        tableView.isHidden = true
        activityIndicatorView.isHidden = false
        errorLabel.isHidden = true
        activityIndicatorView.startAnimating()
    }

    private func setupError() {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.activityIndicatorView.isHidden = true
            self.errorLabel.isHidden = false
            self.activityIndicatorView.stopAnimating()
        }
    }
}

extension CountriesListView: CountriesListViewType {
    func show(state: CountriesListState) {
        switch state {
        case .ready(let countries):
            setupReady(countries)
        case .loading:
            setupLoading()
        case .error:
            setupError()
        }
    }
}


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

protocol CountriesListRepositoryType {
    func requestList(completion: @escaping (Result<[Country], Error>) -> Void)
}

final class CountriesListRepository: CountriesListRepositoryType {
    private let network: NetworkType

    init(network: NetworkType) {
        self.network = network
    }

    func requestList(completion: @escaping (Result<[Country], Error>) -> Void) {
        network.execute(Service.all, type: [Country].self, completion: completion)
    }
    
}

protocol CountriesListPresenterType {
    func requestCountries()
}

final class CountriesListPresenter: CountriesListPresenterType {
    weak var controller: CountriesListViewControllerType?

    private var state: CountriesListState = .loading {
        didSet {
            controller?.show(state: state)
        }
    }

    private let repository = CountriesListRepository(network: Network.shared)

    func requestCountries() {
        state = .loading

        repository.requestList { [weak self] result in
            switch result {
            case .success(let countries):
                self?.handleSucess(countries: countries)
            case .failure:
                self?.state = .error
            }
        }
    }

    private func handleSucess(countries: [Country]) {
        let sortedCountries = countries.sorted(by: { $0.name.official < $1.name.official } )
        state = .ready(countries: sortedCountries)
    }
}
