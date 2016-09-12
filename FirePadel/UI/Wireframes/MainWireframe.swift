import UIKit

final class MainWireframe {
    private let isUserSignedIn: UseCase.IsUserSignedIn
    private let window = UIWindow(frame: UIScreen.main.bounds)
    private let signInWireframe = SignInWireframe()
    
    init(isUserSignedIn: @escaping UseCase.IsUserSignedIn = IsUserSignedIn()) {
        self.isUserSignedIn = isUserSignedIn
    }
    
    func setupKeyWindow() -> UIWindow {
        let controller = createRootViewController()
        window.rootViewController = controller
        window.makeKeyAndVisible()
        return window
    }
    
    private func createRootViewController() -> UIViewController {
        if isUserSignedIn() {
            return UIViewController()
        } else {
            return signInWireframe.rootController
        }
    }
}
