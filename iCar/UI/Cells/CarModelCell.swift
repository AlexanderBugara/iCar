import UIKit

final class CarModelCell: UITableViewCell {
    private weak var titleLabel: UILabel?
    private weak var valueLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func update(viewModel: CarModelsViewModel.CellViewModel?) {
        backgroundColor = viewModel?.backgroundColor
        titleLabel?.text = viewModel?.titleLabelText
        valueLabel?.text = viewModel?.rawTitle
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    private func setupUI() {
        let title = UILabel()
        let value = UILabel()
        value.textColor = .darkGray
        value.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)

        title.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        value.setContentHuggingPriority(.defaultLow, for: .horizontal)
        contentView.add([title, value], layout: .cell)
        self.titleLabel = title
        self.valueLabel = value
        accessoryType = .disclosureIndicator
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
