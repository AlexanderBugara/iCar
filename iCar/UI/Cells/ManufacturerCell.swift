import UIKit

final class ManufacturerCell: UITableViewCell {
    private weak var title: UILabel?
    private weak var value: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func update(viewModel: ManufacturerViewModel.CellViewModel?) {
        backgroundColor = viewModel?.backgroundColor
        title?.text = viewModel?.titleLabelText
        value?.text = viewModel?.rawTitle
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
        self.title = title
        self.value = value
        accessoryType = .disclosureIndicator
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
