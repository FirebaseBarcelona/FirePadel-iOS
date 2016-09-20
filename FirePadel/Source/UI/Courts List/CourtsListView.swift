import UIKit

final class CourtsListView: UIView {
    
    typealias CourtState = CourtCell.CourtState
    
    var courts = [CourtState]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View setup
    
    private func setup() {
        addSubview(tableView)
        tableView.register(CourtCell.self, forCellReuseIdentifier: CourtCell.cellIdentifier)
        tableView.dataSource = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

extension CourtsListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return courts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CourtCell.cellIdentifier, for: indexPath)
        if let courtCell = cell as? CourtCell {
            courtCell.courtState = courts[indexPath.section]
        }
        return cell
    }
}
