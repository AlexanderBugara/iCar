import XCTest
@testable import iCar

final class UIBuilderTests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testCreateManufacturerViewController() throws {
        let expectation = XCTestExpectation(description: "Creation ManufacturerViewController in main queuq")
        Builder.manufacturer.build { manufacturerViewController in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testCreateManufacturerViewControllerWithCustomInjection() throws {
        let expectation = XCTestExpectation(description: "Creation ManufacturerViewController in main queuq")
        var manufacturerBuilder = Builder.manufacturer
        manufacturerBuilder.manufacturerViewModel = MockManufacturerViewModel(networkManager: MockNetworkManager())
        manufacturerBuilder.build { manufacutrerViewController in
            XCTAssertTrue(manufacutrerViewController.viewModel is MockManufacturerViewModel)
            XCTAssertTrue(manufacutrerViewController.viewModel.networkManager is MockNetworkManager)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testCreateManufacturerViewControllerWithCustomNetworkManager() throws {
        let expectation = XCTestExpectation(description: "Creation ManufacturerViewController in main queuq")
        var manufacturerBuilder = Builder.manufacturer
        manufacturerBuilder.networkManager = MockNetworkManager()
        manufacturerBuilder.build { manufacutrerViewController in
            XCTAssertTrue(manufacutrerViewController.viewModel is ManufacturerViewModel)
            XCTAssertTrue(manufacutrerViewController.viewModel.networkManager is MockNetworkManager)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

final class MockManufacturerViewModel: ManufacturerViewModellable {
    var networkManager: NetworkManaging
    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }
    func setup() {
    }
}

final class MockNetworkManager: NetworkManaging {
    var isInProgress: Bool = false

    func fetch(range: Range<Int>, queue: DispatchQueue?) {

    }
}
