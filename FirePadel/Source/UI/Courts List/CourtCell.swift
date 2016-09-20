import UIKit

final class CourtCell: UITableViewCell {
    
    typealias CourtState = CourtView.CourtState
    static let cellIdentifier = "CourtCell"

    var courtState = CourtState(players: [], actionButtonsState: .join) {
        didSet {
            courtView.courtState = courtState
        }
    }
    
    private let courtView: CourtView = {
        let courtState = CourtState(players: [], actionButtonsState: .join)
        let courtView = CourtView(courtState: courtState)
        courtView.translatesAutoresizingMaskIntoConstraints = false
        return courtView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
