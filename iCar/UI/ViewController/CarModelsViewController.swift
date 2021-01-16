import UIKit

final class CarModelsViewController: UIViewController, PagableViewController {
    var viewModel: CarModelsViewModel
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CarModelCell.self, forCellReuseIdentifier: Constants.manufacurerCellId)
        return tableView
    }()

    // MARK: Init

    /// Initialization CarModelsViewController with CarModelsViewModel
    /// - Returns : CarModelsViewController

    init(viewModel: CarModelsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension CarModelsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.manufacurerCellId, for: indexPath) as? CarModelCell else {
            return UITableViewCell()
        }
        cell.update(viewModel: viewModel.cells[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate

extension CarModelsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(indexPath: indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll(position: scrollView.contentOffset.y, scrollHeight: scrollView.frame.size.height)
    }
}

extension CarModelsViewController: ViewModallableDelegate {
    func reloadTable() {
        tableView.tableFooterView = nil
        tableView.reloadData()
    }
}
