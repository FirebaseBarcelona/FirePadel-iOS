import UIKit

final class MainWireframe {
    private let isUserSignedIn: UseCase.IsUserSignedIn
    private let window = UIWindow(frame: UIScreen.main.bounds)
    private var signInWireframe: SignInWireframe?
    let googleAuthenticationService = GoogleAuthenticationService()
    
    init() {
        isUserSignedIn = IsUserSignedInUseCase(signInService: FirebaseSignInService())
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
            let signInWireframe = SignInWireframe(authenticationService: googleAuthenticationService)
            self.signInWireframe = signInWireframe
            return signInWireframe.rootController
        }
    }
}
