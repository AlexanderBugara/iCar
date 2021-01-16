import UIKit

protocol CarModelsViewModelDelegate: AnyObject {
    func reloadTable()
}

final class CarModelsViewModel {
    private(set) var networkManager: NetworkManaging
    weak var delegate: ViewModallableDelegate?
    private let router: Routing
    private let manufacturer: Manufacturer
    private(set) var cells = [CellViewModel]()
    var path: Constants.Path?
    var page: CodablePage? {
        didSet {
            guard let page = page, let wkda = page.wkda else {
                return
            }
            let newCells = wkda.enumerated().map { (index, element) in
                CellViewModel(rawTitle: element.name, index: cells.count-1+index)
            }
            cells.append(contentsOf: newCells)
            delegate?.reloadTable()
        }
    }

    // MARK: Init

    init(networkManager: NetworkManaging, router: Routing, manufacturer: Manufacturer, path: Constants.Path?) {
        self.networkManager = networkManager
        self.router = router
        self.manufacturer = manufacturer
        self.path = path
    }
}

extension CarModelsViewModel: ViewModallable {
    var title: String { "Car models manufacturer: \(manufacturer.name)" }
    func didSelect(indexPath: IndexPath) {
        let car = cells[indexPath.row]
        router.next(.showFinalMessage("Manufacturer: \(manufacturer.name), model: \(car.rawTitle)"))
    }
}

extension CarModelsViewModel: PagableViewModel {
    func queryParams(page: Int, itemsPerPage: Int) -> [String : String] {
        [
            Constants.pageSize: "\(itemsPerPage)",
            Constants.wa_key: Constants.wa_key_value,
            Constants.page: "\(page)",
            Constants.manufacturer: manufacturer.manufacturerId
        ]
    }

    struct CellViewModel: CellViewModellable {
        var rawTitle: String
        var index: Int
        var titleLabelText: String {
            "Model is: \(rawTitle)"
        }
    }
}
