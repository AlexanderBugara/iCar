import XCTest
@testable import iCar

final class BuilderTests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testCreateManufacturerViewController() throws {
        let expectation = XCTestExpectation(description: "Creation ManufacturerViewController in main queuq")
        Builder<ManufacturerViewModel, CarModelsViewModel>.manufacturers.build { manufacturerViewController in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testCreateManufacturerViewControllerWithCustomInjection() throws {
        let expectation = XCTestExpectation(description: "Creation ManufacturerViewController in main queuq")
        var manufacturerBuilder = Builder<MockManufacturerViewModel, CarModelsViewModel>.manufacturers
        manufacturerBuilder.manufacturerViewModel = MockManufacturerViewModel(networkManager: MockNetworkManager())
        manufacturerBuilder.build { manufacutrerViewController in
            XCTAssertTrue(manufacutrerViewController.viewModel.networkManager is MockNetworkManager)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testCreateManufacturerViewControllerWithCustomNetworkManager() throws {
        let expectation = XCTestExpectation(description: "Creation ManufacturerViewController in main queuq")
        var manufacturerBuilder = Builder<ManufacturerViewModel, CarModelsViewModel>.manufacturers
        manufacturerBuilder.networkManager = MockNetworkManager()
        manufacturerBuilder.build { manufacutrerViewController in
            XCTAssertTrue(manufacutrerViewController.viewModel.networkManager is MockNetworkManager)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
