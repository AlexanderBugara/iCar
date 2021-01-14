import XCTest
@testable import iCar

final class ManufacturerViewModelTests: XCTestCase {
    private var manufacturerViewModel: ManufacturerViewModel!
    override func setUpWithError() throws {
        manufacturerViewModel = ManufacturerViewModel(networkManager: MockNetworkManager())
    }

    override func tearDownWithError() throws {
        manufacturerViewModel = nil
    }

    func testExample() throws {
    }
}
