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

    private let scrollToTopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .gray
        button.layer.cornerRadius = 4
        button.isHidden = true
        return button
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
        scrollToTopButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(tableView)
        addSubview(activityIndicatorView)
        addSubview(errorLabel)
        addSubview(scrollToTopButton)
        
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        NSLayoutConstraint.activate([
            scrollToTopButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            scrollToTopButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])

        addActions()
    }

    private func addActions() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollToTopButton.addTarget(self, action: #selector(scrollToTop), for: .touchUpInside)
    }

    @objc
    private func refresh() {
        delegate?.didPullToRefresh()
        refreshControl.endRefreshing()
    }

    @objc
    private func scrollToTop() {
        tableView.scrollToTop()
    }

    private func setupReady(_ countries: [Country]) {
        dataSource.updateItems(countries)

        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.scrollToTopButton.isHidden = false
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
        scrollToTopButton.isHidden = true

        activityIndicatorView.startAnimating()
    }

    private func setupError() {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.activityIndicatorView.isHidden = true
            self.errorLabel.isHidden = false
            self.scrollToTopButton.isHidden = true

            self.activityIndicatorView.stopAnimating()
        }
    }
}

extension CountriesListView: CountriesListViewType {
    func updateViewState(_ state: CountriesListState) {
        switch state {
        case .ready(let countries):
            setupReady(countries)
        case .loading:
            setupLoading()
        case .error:
            setupError()
        }
    }

    func setDelegate(_ delegate: CountriesListViewDelegate?) {
        self.delegate = delegate
    }
}
