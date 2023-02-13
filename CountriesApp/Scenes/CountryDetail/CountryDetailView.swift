import UIKit

final class CountryDetailView: UIView {
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    private let flagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    private let populationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        headerStackView.addArrangedSubview(flagLabel)
        headerStackView.addArrangedSubview(titleLabel)
        addSubview(headerStackView)
        addSubview(populationLabel)
    }

    private func setupConstraints() {
        flagLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        populationLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            populationLabel.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 16),
            populationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            populationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }

    // Public methods
    func updateUI(with country: CountryModel) {
        titleLabel.text = country.nameCommon
        populationLabel.text = String(country.population)
        flagLabel.text = country.flag
    }
}
