import UIKit
import GoogleSignIn

class SignInController: UIViewController, SignInUI, GIDSignInUIDelegate {
    
    weak var delegate: SignInUIDelegate?
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = SignInView()
    }
    
    override func viewDidLoad() {
        delegate?.viewLoaded()
    }
}
