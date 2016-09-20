import UIKit

final class PlayersView: UIStackView {
    
    struct Player {
        let name: String
        let avatarURL: URL
    }
    
    static private let subviewSpacing: CGFloat = 8

    private var avatarAndNameViews = [AvatarAndNameView]()
    
    var players: [Player] {
        didSet {
            updateAvatarAndNameViews()
        }
    }
    
    // MARK: Initialization
    
    init(players: [Player]) {
        self.players = players
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View setup
    
    private func setup() {
        setupAvatarAndNameViews()
        configureLayout()
    }
    
    private func setupAvatarAndNameViews() {
        avatarAndNameViews = players.map { player in
            return AvatarAndNameView(name: player.name, avatarURL: player.avatarURL)
        }
        
        avatarAndNameViews.forEach { view in
            addArrangedSubview(view)
        }
    }
    
    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = PlayersView.subviewSpacing
    }
    
    private func updateAvatarAndNameViews() {
        removeOldAvatarAndNameViews()
        setupAvatarAndNameViews()
    }
    
    private func removeOldAvatarAndNameViews() {
        avatarAndNameViews.forEach { view in
            removeArrangedSubview(view)
        }
    }
}
