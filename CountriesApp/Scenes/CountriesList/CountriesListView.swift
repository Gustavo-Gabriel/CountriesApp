import UIKit

final class CountriesListView: UIView {
    weak var delegate: CountriesListViewDelegate?

    private let dataSource = CountriesListDataSource()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.backgroundColor = .systemBackground
        return tableView
    }()

    private let refreshControl = UIRefreshControl()

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
        tableView.refreshControl = refreshControl
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

        addActions()
    }

    private func addActions() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    @objc
    private func refresh() {
        delegate?.refresh()
        refreshControl.endRefreshing()
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
