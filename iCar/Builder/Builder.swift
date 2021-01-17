import UIKit

// MARK: UIBuilder protocol

protocol UIBuilder {
    associatedtype T
    func build(completion: @escaping (T) -> Void)
}

// MARK: Bulder interface

struct Builder<T: ViewModellable, U: ViewModellable> where T.PageType == CodablePage, T.CellViewModelType == ManufacturerViewModel.CellViewModel, U.PageType == CodablePage, U.CellViewModelType == CarModelsViewModel.CellViewModel {
    static var manufacturers: Manufacturers<T> { Manufacturers() }
    static var carModels: CarModels<U> { CarModels() }
}

extension Builder {
    struct Manufacturers<ManufacturerViewModelType: ViewModellable> : UIBuilder where ManufacturerViewModelType.CellViewModelType == ManufacturerViewModel.CellViewModel, ManufacturerViewModelType.PageType == CodablePage {
        var manufacturerViewModel: ManufacturerViewModelType?
        var networkManager: NetworkManaging?
        var navigationController: UINavigationController?

        func build(completion: @escaping (ManufacturerViewController<ManufacturerViewModelType>) -> Void) {

            guard let networkManager = networkManager == nil ? NetworkManager() : networkManager else {
                return
            }

            let viewModel1: ManufacturerViewModelType? = ManufacturerViewModel(networkManager: networkManager, router: Router(navigationController: navigationController), path: .manufacturers) as? ManufacturerViewModelType
            guard let viewModel = manufacturerViewModel == nil ? viewModel1 : manufacturerViewModel else {
                return
            }

            let manufacturerViewController = ManufacturerViewController(viewModel: viewModel)
            DispatchQueue.main.async {
                completion(manufacturerViewController)
            }
        }
    }
    struct CarModels<ModelsCarsViewModelType: ViewModellable>: UIBuilder where ModelsCarsViewModelType.CellViewModelType == CarModelsViewModel.CellViewModel, ModelsCarsViewModelType.PageType == CodablePage {
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
