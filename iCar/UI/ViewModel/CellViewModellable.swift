import UIKit

protocol CellViewModellable {
    var rawTitle: String { get set }
    var index: Int { get set }
    var titleLabelText: String { get }
}

extension CellViewModellable {
    var backgroundColor: UIColor {
        index % 2 == 0 ? .lightGray : .white
    }
}
