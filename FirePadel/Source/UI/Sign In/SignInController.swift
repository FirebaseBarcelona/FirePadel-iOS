import UIKit

class SignInController<View: SignInUI>: UIViewController where View: UIView {
    var mainView: View
    
    // MARK: - Initialization
    
    init(view: View) {
        mainView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = mainView
    }
}
