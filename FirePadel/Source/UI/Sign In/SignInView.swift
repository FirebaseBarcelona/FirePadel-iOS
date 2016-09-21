import UIKit
import GoogleSignIn

class SignInView: UIView {
    
    private let signInButton: UIControl = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        backgroundColor = UIColor.white
        addSubview(signInButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        signInButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signInButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
