import UIKit
import GoogleSignIn

final class SignInWireframe {
    weak var delegate: SignInWireframeDelegate?
    
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
        presenter.delegate = self
        controller.delegate = presenter
    }
}

extension SignInWireframe: SignInPresenterDelegate {
    func signInFinished() {
        delegate?.signInUINeedsToBeDissmissed()
    }
}

protocol SignInWireframeDelegate: class {
    func signInUINeedsToBeDissmissed()
}
