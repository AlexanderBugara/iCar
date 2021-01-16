import Foundation

protocol ViewModallable {
    associatedtype T: Page
    associatedtype ViewModel
    var networkManager: NetworkManaging { get }
    var title: String { get }
    var itemsCount: Int { get }
    var isLoading: Bool { get }
    var delegate: ViewModallableDelegate? { get set }
    var page: T? { get set }
    var cells: [ViewModel] { get }
    func didSelect(indexPath: IndexPath)
    func nextPage()
}

extension ViewModallable {
    var itemsCount: Int { cells.count }
    var isLoading: Bool { networkManager.isInProgress }
}

protocol ViewModallableDelegate: AnyObject {
    func reloadTable()
}
