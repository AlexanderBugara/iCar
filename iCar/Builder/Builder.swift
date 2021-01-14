import Foundation

// MARK: UIBuilder protocol

protocol UIBuilder {
    associatedtype T
    func build(completion: @escaping (T) -> Void)
}

// MARK: Bulder interface

struct Builder {
    static var manufacturer: Manufacturer {
        Manufacturer()
    }
}

extension Builder {
    struct Manufacturer: UIBuilder {
        var manufacturerViewModel: ManufacturerViewModel?
        var networkManager: NetworkManaging?

        func build(completion: @escaping (ManufacturerViewController) -> Void) {

            guard let networkManager = networkManager == nil ? NetworkManager() : networkManager else {
                return
            }

            guard let viewModel = manufacturerViewModel == nil ? ManufacturerViewModel(networkManager: networkManager) : manufacturerViewModel else {
                return
            }

            let manufacturerViewController = ManufacturerViewController(viewModel: viewModel)
            DispatchQueue.main.async {
                completion(manufacturerViewController)
            }
        }
    }
}
