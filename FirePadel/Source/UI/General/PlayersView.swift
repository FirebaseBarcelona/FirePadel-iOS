import UIKit

final class PlayersView: UIStackView {
    
    static private let subviewSpacing: CGFloat = 8

    private let avatarAndNameViews: [AvatarAndNameView]
    
    // MARK: Initialization
    
    init(players: [Player]) {
        avatarAndNameViews = players.map { player in
            return AvatarAndNameView(name: player.name, avatarURL: player.avatarURL)
        }
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
        avatarAndNameViews.forEach { view in
            addArrangedSubview(view)
        }
    }
    
    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = PlayersView.subviewSpacing
    }
    
    struct Player {
        let name: String
        let avatarURL: URL
    }
}
