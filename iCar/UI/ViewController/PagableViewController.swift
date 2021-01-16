import UIKit

protocol PagableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ViewModallableDelegate {
    associatedtype T: ViewModallable
    var viewModel: T { get set }
    var tableView: UITableView { get }
    init(viewModel: T)
    func setupUI()
    func setupLayout()
    func didScroll(position: CGFloat, scrollHeight: CGFloat)
    func didSelect(indexPath: IndexPath)
}

extension PagableViewController {

    // MARK: Setup UI

    func setupUI() {
        view.backgroundColor = .blue
        view.addSubview(tableView)
        navigationItem.title = viewModel.title
        viewModel.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: Setup Layout

    func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        footerView.addSubview(spinner)
        spinner.center = footerView.center
        tableView.tableFooterView = footerView
        return footerView
    }

    func didScroll(position: CGFloat, scrollHeight: CGFloat) {
        if position > (tableView.contentSize.height - 100 - scrollHeight) && !viewModel.isLoading {
            tableView.tableFooterView = createSpinnerFooter()
            viewModel.nextPage()
        }
    }

    func didSelect(indexPath: IndexPath) {
        viewModel.didSelect(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
