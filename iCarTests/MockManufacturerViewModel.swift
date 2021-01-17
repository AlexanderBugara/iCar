import XCTest
@testable import iCar

struct MockCellViewModel: CellViewModellable {
    var rawTitle: String
    var index: Int
    var titleLabelText: String
}

final class MockManufacturerViewModel: ViewModellable {
    typealias PageType = CodablePage
    typealias CellViewModelType = ManufacturerViewModel.CellViewModel

    var networkManager: NetworkManaging
    var indexPath: IndexPath?
    var nextPageDidCall = false
    var setupDidCall = false
    var title: String { "mock manufacturer view model" }
    var delegate: ViewModellableDelegate?
    var page: CodablePage?
    var cells = [CellViewModelType]()

    func didSelect(indexPath: IndexPath) {
        self.indexPath = indexPath
    }

    func nextPage() {
        nextPageDidCall = true
    }

    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }

    func setup() {
        self.setupDidCall = true
    }
}
