import UIKit

final class CourtsListView: UIView {
    
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
        setupConstraints()
    }
    
    private func setupConstraints() {
    }
}
