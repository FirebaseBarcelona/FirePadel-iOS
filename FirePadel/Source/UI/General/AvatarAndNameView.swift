import UIKit

final class AvatarAndNameView: UIStackView {
    
    static private let subviewSpacing: CGFloat = 8
    
    private let avatarView: AvatarView
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: Initialization
    
    init(name: String, avatarURL: URL) {
        self.avatarView = AvatarView(size: .standard, url: avatarURL)
        nameLabel.text = name
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View setup
    
    private func setup() {
        addSubviews()
        configureLayout()
    }
    
    private func addSubviews() {
        addArrangedSubview(avatarView)
        addArrangedSubview(nameLabel)
    }
    
    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        spacing = AvatarAndNameView.subviewSpacing
    }
}
