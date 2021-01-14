import UIKit

final class ManufacturerViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ManufacturerCell.self, forCellReuseIdentifier: Constants.manufacurerCellId)
        return tableView
    }()

    let viewModel: ManufacturerViewModel

    // MARK: Init

    /// Initialization ManufacturerViewController with ManufacturerViewModellable
    /// - Returns : ManufacturerViewController

    init(viewModel: ManufacturerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup UI

    private func setupUI() {
        view.backgroundColor = .blue
        view.addSubview(tableView)
        navigationItem.title = viewModel.title
        viewModel.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: Setup Layout

    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: View lifecircle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        viewModel.setup()
    }
}

// MARK: UITableViewDataSource

extension ManufacturerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.manufacurerCellId, for: indexPath) as? ManufacturerCell else {
            return UITableViewCell()
        }
        cell.update(viewModel: viewModel.cells?[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate

extension ManufacturerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension ManufacturerViewController: ManufacturerViewModelDelegate {
    func reloadTable() {
        tableView.reloadData()
    }
}
