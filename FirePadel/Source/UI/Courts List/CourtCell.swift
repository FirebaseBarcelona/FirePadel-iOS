import UIKit

final class CourtCell: UITableViewCell {
    
    typealias ButtonAction = (Void) -> Void
    
    typealias CourtState = CourtView.CourtState
    static let cellIdentifier = "CourtCell"

    var courtState = CourtState(players: [], actionButtonsState: .join) {
        didSet {
            courtView.courtState = courtState
        }
    }
    
    var joinButtonAction: ButtonAction? {
        get {
            return courtView.joinButtonAction
        }
        set {
            courtView.joinButtonAction = newValue
        }
    }
    
    var leaveButtonAction: ButtonAction? {
        get {
            return courtView.leaveButtonAction
        }
        set {
            courtView.leaveButtonAction = newValue
        }
    }
    
    var chatButtonAction: ButtonAction? {
        get {
            return courtView.chatButtonAction
        }
        set {
            courtView.chatButtonAction = newValue
        }
    }
    
    private let courtView: CourtView = {
        let courtState = CourtState(players: [], actionButtonsState: .join)
        let courtView = CourtView(courtState: courtState)
        courtView.translatesAutoresizingMaskIntoConstraints = false
        return courtView
    }()
    
    // MARK: Initilization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View setup
    
    private func setup() {
        contentView.addSubview(courtView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        courtView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        courtView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        courtView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        courtView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
