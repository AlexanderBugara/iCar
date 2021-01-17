import UIKit

protocol Page: Decodable {
    var page: Int? { get set }
    var pageSize: Int? { get set }
    var totalPageCount: Int? { get set }
}

protocol PagableViewModel: AnyObject {
    associatedtype T: Page
    var page: T? { get set }
    var path: Constants.Path? { get set }
    var networkManager: NetworkManaging { get }
    func setup()
    func nextPage()
    func queryParams(page: Int, itemsPerPage: Int) -> [String: String]
}

extension PagableViewModel {
    func setup() {
        fetch(index: 0)
    }

    func nextPage() {
        guard let pageIndex = page?.page else {
            return
        }
        fetch(index: pageIndex + 1)
    }

    private func fetch(index: Int, itemsCount: Int = Constants.itemsCount) {
        guard networkManager.isInProgress == false, let path = path else {
            return
        }
        let parameters = queryParams(page: index, itemsPerPage: itemsCount)
        networkManager.fetch(path: path, queryParams: parameters, type: T.self) { [weak self] result in
            switch result {
            case .success(let page): self?.page = page
            case .failure(_): break
            }
        }
    }
}
