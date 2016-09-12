import UIKit

class SignInView: UIView, SignInUI {
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
