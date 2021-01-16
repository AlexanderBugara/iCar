import UIKit

// MARK: UIBuilder protocol

protocol UIBuilder {
    associatedtype T
    func build(completion: @escaping (T) -> Void)
}

// MARK: Bulder interface

struct Builder {
    static var manufacturers: Manufacturers { Manufacturers() }
    static var carModels: CarModels { CarModels() }
}

extension Builder {
    struct Manufacturers: UIBuilder {
        var manufacturerViewModel: ManufacturerViewModel?
        var networkManager: NetworkManaging?
        var navigationController: UINavigationController?

        func build(completion: @escaping (ManufacturerViewController) -> Void) {

            guard let networkManager = networkManager == nil ? NetworkManager() : networkManager else {
                return
            }

            guard let viewModel = manufacturerViewModel == nil ? ManufacturerViewModel(networkManager: networkManager, router: Router(navigationController: navigationController), path: .manufacturers) : manufacturerViewModel else {
                return
            }

            let manufacturerViewController = ManufacturerViewController(viewModel: viewModel)
            DispatchQueue.main.async {
                completion(manufacturerViewController)
            }
        }
    }
    struct CarModels: UIBuilder {
        var carViewModel: CarModelsViewModel?
        var networkManager: NetworkManaging?
        var navigationController: UINavigationController?
        var manufacturer: Manufacturer?

        func build(completion: @escaping (CarModelsViewController) -> Void) {
            guard let networkManager = networkManager == nil ? NetworkManager() : networkManager, let manufacturer = manufacturer else {
                return
            }
            let router = Router(navigationController: navigationController)
            guard let viewModel = carViewModel == nil ? CarModelsViewModel(networkManager: networkManager, router: router, manufacturer: manufacturer, path: .models) : carViewModel else {
                return
            }

            let carsViewController = CarModelsViewController(viewModel: viewModel)
            DispatchQueue.main.async {
                completion(carsViewController)
            }
        }
    }
}
