import UIKit

typealias Message = String

struct Manufacturer: Equatable {
    var name: String
    var manufacturerId: String
}

enum RoutingAction {
    case showCarModels(Manufacturer)
    case showFinalMessage(Message)
}

protocol Routing {
    var navigationController: UINavigationController? { get set }
    func next(_ action: RoutingAction)
}

final class Router: Routing {
    var navigationController: UINavigationController?
    func next(_ action: RoutingAction) {
        switch action {
        case .showCarModels(let manufacturer):
            var carModelsBuilder = Builder<ManufacturerViewModel, CarModelsViewModel>.carModels
            carModelsBuilder.manufacturer = manufacturer
            carModelsBuilder.navigationController = navigationController
            carModelsBuilder.build { [weak self] carModelsViewController in
                self?.navigationController?.show(carModelsViewController, sender: nil)
            }
        case .showFinalMessage(let messageText):
            let alert = UIAlertController(title: "Message", message: messageText, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            navigationController?.present(alert, animated: true)
        }
    }
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}
