import UIKit

protocol ManufacturerViewModellable {
    var title: String { get }
}

protocol ManufacturerViewModelDelegate: AnyObject {
    func reloadTable()
}

final class ManufacturerViewModel: ManufacturerViewModellable {
    private(set) var cells: [CellViewModel]?
    private(set) var networkManager: NetworkManaging
    weak var delegate: ManufacturerViewModelDelegate?

    var page: CarModelsPage? {
        didSet {
            guard let page = page else {
                return
            }
            self.cells = page.wkda?.enumerated().map { (index, element) in
                CellViewModel(manufactirer: element.name, index: index)
            }
            delegate?.reloadTable()
        }
    }

    var itemsCount: Int { cells?.count ?? 0 }
    var title: String {
        "Manufacturer screen"
    }

    // MARK: Init

    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }
}

extension ManufacturerViewModel: Pagable {
    struct CellViewModel {
        var manufactirer: String
        var index: Int
        var titleLabelText: String {
            "Manufacturer is: \(manufactirer)"
        }
        var backgroundColor: UIColor {
            index % 2 == 0 ? .lightGray : .white
        }
    }
}

protocol Page: Decodable {
    var page: Int? { get set }
    var pageSize: Int? { get set }
    var totalPageCount: Int? { get set }
}

protocol Pagable: AnyObject {
    associatedtype T: Decodable
    var page: T? { get set }
    var networkManager: NetworkManaging { get }
    func setup()
    func nextPage()
}

extension Pagable {
    func setup() {
        fetch(index: 0)
    }

    func nextPage() {
        fetch(index: 1)
    }

    private func fetch(index: Int, itemsCount: Int = Constants.itemsCount) {
        guard networkManager.isInProgress == false else {
            return
        }
        networkManager.fetch(pageIndex: index, itemsCount: Constants.itemsCount, type: T.self) { [weak self] result in
            switch result {
            case .success(let page): self?.page = page
            case .failure(let error): break
            }
        }
    }
}
