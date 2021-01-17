import UIKit

final class ManufacturerViewModel: ViewModellable {
    private(set) var cells = [CellViewModel]()
    private(set) var networkManager: NetworkManaging
    weak var delegate: ViewModellableDelegate?
    private let router: Routing
    var path: Constants.Path?
    var page: CodablePage? {
        didSet {
            guard let page = page, let wkda = page.wkda else {
                return
            }
            let newCells = wkda.enumerated().map { (index, element) -> CellViewModel in
                CellViewModel(rawTitle: element.name, value: element.value, index: cells.count + index)
            }
            cells.append(contentsOf: newCells)
            delegate?.reloadTable()
        }
    }

    var title: String { "Manufacturer screen" }

    // MARK: Init

    init(networkManager: NetworkManaging, router: Routing, path: Constants.Path?) {
        self.networkManager = networkManager
        self.router = router
        self.path = path
    }

    func didSelect(indexPath: IndexPath) {
        let item = cells[indexPath.row]
        router.next(.showCarModels(Manufacturer(name: item.rawTitle, manufacturerId: item.value)))
    }
}

extension ManufacturerViewModel: PagableViewModel {
    func queryParams(page: Int, itemsPerPage: Int) -> [String : String] {
        [
            Constants.pageSize: "\(itemsPerPage)",
            Constants.wa_key: Constants.wa_key_value,
            Constants.page: "\(page)"
        ]
    }

    struct CellViewModel: CellViewModellable {
        var rawTitle: String
        var value: String
        var index: Int
        var titleLabelText = "Manufacturer is : "
    }
}
