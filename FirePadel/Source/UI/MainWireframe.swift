import UIKit

final class MainWireframe {
    private let isUserSignedIn: UseCase.IsUserSignedIn
    private let window = UIWindow(frame: UIScreen.main.bounds)
    private var signInWireframe: SignInWireframe?
    private var courtListWireframe: CourtListWireframe?
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
            let courtListWireframe = CourtListWireframe()
            let controller = courtListWireframe.rootController
            let navigationController = UINavigationController(rootViewController: controller)
            self.courtListWireframe = courtListWireframe
            return navigationController
        } else {
            let signInWireframe = SignInWireframe(authenticationService: googleAuthenticationService)
            self.signInWireframe = signInWireframe
            return signInWireframe.rootController
        }
    }
}
