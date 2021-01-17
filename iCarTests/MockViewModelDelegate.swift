import XCTest
@testable import iCar

final class MockViewModelDelegate: ViewModellableDelegate {
    var reloadTableDidCall = false
    func reloadTable() {
        reloadTableDidCall = true
    }
}
