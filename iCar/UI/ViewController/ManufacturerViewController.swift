import UIKit

final class ManufacturerViewController<ViewModelType: ViewModellable> : UIViewController, PagableViewController, UITableViewDataSource where ViewModelType.PageType == CodablePage,
ViewModelType.CellViewModelType == ManufacturerViewModel.CellViewModel {
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ManufacturerCell.self, forCellReuseIdentifier: Constants.manufacurerCellId)
        return tableView
    }()

    var viewModel: ViewModelType
    var endReached: Bool = false
    // MARK: Init

    /// Initialization ManufacturerViewController with ManufacturerViewModellable
    /// - Returns : ManufacturerViewController

    init(viewModel: ViewModelType) {
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

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.manufacurerCellId, for: indexPath) as? ManufacturerCell else {
            return UITableViewCell()
        }
        cell.update(viewModel: viewModel.cells[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        checkEnd(indexPath)
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(indexPath: indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll(position: scrollView.contentOffset.y, scrollHeight: scrollView.frame.size.height)
    }
}

extension ManufacturerViewController: ViewModellableDelegate {
    func reloadTable() {
        tableView.tableFooterView = nil
        tableView.reloadData()
    }
}
