import UIKit
import GoogleSignIn

final class SignInWireframe {
    private let authenticationService: AuthenticationService
    private let presenter: SignInPresenter
    private let controller = SignInController()
    
    var rootController: UIViewController {
        return controller
    }
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
        let signInUseCase = SignInUseCase(signInService: FirebaseSignInService(),
                                          authenticationService: authenticationService)
        presenter = SignInPresenter(ui: controller, signInUseCase: signInUseCase)
        controller.delegate = presenter
    }
}
