import XCTest
@testable import iCar

final class ManufacturerViewModelTests: XCTestCase {
    private var viewModel: ManufacturerViewModel!
    private var mockNetworkManager: MockNetworkManager!
    private var mockRouter: MockRouter!
    private var mockViewModelDelegate: MockViewModelDelegate!
    private var path = Constants.Path.manufacturers
    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        mockRouter = MockRouter()
        mockViewModelDelegate = MockViewModelDelegate()
        viewModel = ManufacturerViewModel(networkManager: mockNetworkManager, router: mockRouter, path: path)
        viewModel.delegate = mockViewModelDelegate
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockRouter = nil
        mockNetworkManager = nil
        mockViewModelDelegate = nil
    }

    func testSetup() {
        XCTAssertEqual(viewModel.title, "Manufacturer screen")
        viewModel.setup()
        XCTAssertEqual(mockNetworkManager.fetchPath, path)
        XCTAssertTrue(mockViewModelDelegate.reloadTableDidCall)
        let queryParams = [
            Constants.pageSize: "\(15)",
                Constants.wa_key: Constants.wa_key_value,
                Constants.page: "\(0)"
            ]
        XCTAssertEqual(mockNetworkManager.queryParams, queryParams)
    }

    func testFirstPage() {
        viewModel.setup()
        XCTAssertEqual(mockNetworkManager.fetchPath, path)
        guard let page = page(index: 0) else {
            XCTFail("Page 0 is nil")
            return
        }
        XCTAssertEqual(viewModel.page, page)
    }

    func testNextPage() {
        viewModel.setup()
        viewModel.nextPage()
        guard let page = page(index: 1) else {
            XCTFail("Page 1 is nil")
            return
        }
        XCTAssertEqual(viewModel.page, page)
    }

    func testNavigation() {
        viewModel.setup()
        viewModel.didSelect(indexPath: IndexPath(item: 0, section: 0))
        switch mockRouter.routingAction {
        case .showCarModels(let manufacturer):
            guard let page = page(index: 0) else {
                XCTFail("Page 0 is nil")
                return
            }
            guard let wkda = page.wkda?[0] else {
                XCTFail("wkda is nil")
                return
            }
            let manufacturerSample = Manufacturer(name: wkda.name, manufacturerId: wkda.value)
            XCTAssertEqual(manufacturer, manufacturerSample)
        default:
            XCTFail("Unexpected navigation action")
            break
        }
    }

    func page(index: Int) -> CodablePage? {
        let bundle = Bundle(for: MockNetworkManager.self)
        guard let path = bundle.path(forResource: "Page\(index)", ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: path)), let result = try? JSONDecoder().decode(CodablePage.self, from: data) else {
            return nil
        }
        return result
    }
}

