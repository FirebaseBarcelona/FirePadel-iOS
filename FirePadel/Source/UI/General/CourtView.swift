import UIKit

final class CourtView: UIStackView {
    
    typealias Player = PlayersView.Player
    
    struct CourtState {
        let players: [Player]
        let actionButtonsState: CourtActionButtons.State
    }
    
    private static let contentMargin: CGFloat = 8
    
    private let playersView: PlayersView
    private let actionButtons = CourtActionButtons()
    
    var courtState: CourtState {
        didSet {
            playersView.players = courtState.players
            actionButtons.state = courtState.actionButtonsState
        }
    }
    
    var joinButtonAction: CourtActionButtons.ButtonAction? {
        get {
            return actionButtons.joinButtonAction
        }
        set {
            actionButtons.joinButtonAction = newValue
        }
    }
    
    var leaveButtonAction: CourtActionButtons.ButtonAction? {
        get {
            return actionButtons.leaveButtonAction
        }
        set {
            actionButtons.leaveButtonAction = newValue
        }
    }
    
    var chatButtonAction: CourtActionButtons.ButtonAction? {
        get {
            return actionButtons.chatButtonAction
        }
        set {
            actionButtons.chatButtonAction = newValue
        }
    }
    
    // MARK: Initialization
    
    init(courtState: CourtState) {
        self.courtState = courtState
        playersView = PlayersView(players: courtState.players)
        actionButtons.state = courtState.actionButtonsState
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
        addArrangedSubview(playersView)
        addArrangedSubview(actionButtons)
    }
    
    private func configureLayout() {
        distribution = .equalSpacing
        alignment = .bottom
        isLayoutMarginsRelativeArrangement = true
        translatesAutoresizingMaskIntoConstraints = false
        let margin = CourtView.contentMargin
        layoutMargins = UIEdgeInsets(top: margin,
                                     left: margin,
                                     bottom: margin,
                                     right: margin)
    }
}
