import XCTest
@testable import iCar

final class MockRouter: Routing {
    var routingAction: RoutingAction?
    var navigationController: UINavigationController?
    func next(_ action: RoutingAction) {
        routingAction = action
    }
}
