import Foundation

protocol ViewModellable {
    associatedtype PageType: Page
    associatedtype CellViewModelType: CellViewModellable
    var networkManager: NetworkManaging { get }
    var title: String { get }
    var itemsCount: Int { get }
    var isLoading: Bool { get }
    var delegate: ViewModellableDelegate? { get set }
    var page: PageType? { get set }
    var cells: [CellViewModelType] { get }
    var isNewPageExist: Bool { get }
    func didSelect(indexPath: IndexPath)
    func nextPage()
    func setup()

}

extension ViewModellable {
    var itemsCount: Int { cells.count }
    var isLoading: Bool { networkManager.isInProgress }
    var isNewPageExist: Bool {
        guard let page = page, let index = page.page, let total = page.totalPageCount, index == total - 1 else {
            return true
        }
        return false
    }
}

protocol ViewModellableDelegate: AnyObject {
    func reloadTable()
}
