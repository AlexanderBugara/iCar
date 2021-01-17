import UIKit

enum LayoutType {
    case cell
}

extension UIView {
    func add(_ views: [UIView]) {
        for (_, v) in views.enumerated() {
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
    }

    func add(_ views: [UIView], layout type: LayoutType) {
        switch type {
        case .cell:
            let horizontalStack = UIStackView(arrangedSubviews: views)
            horizontalStack.alignment = .center
            horizontalStack.axis = .horizontal
            add([horizontalStack])
            let constraints = [
                horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
                horizontalStack.centerYAnchor.constraint(equalTo: centerYAnchor)
//                horizontalStack.topAnchor.constraint(equalTo: topAnchor),
//                horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
        }
    }
}
