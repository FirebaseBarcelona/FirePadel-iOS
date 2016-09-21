import UIKit

final class CourtListWireframe: NSObject {
    fileprivate let navController: UINavigationController
    fileprivate let controller = CourtListController()
    fileprivate let presenter: CourtListPresenter
    fileprivate let authenticationService: AuthenticationService
    
    fileprivate var signInWireframe: SignInWireframe?
    fileprivate var chatWireframe: ChatWireframe?
    
    var rootController: UIViewController {
        return navController
    }
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
        presenter = CourtListPresenter(ui: controller,
                                       isUserSignedIn: IsUserSignedInUseCase(),
                                       getCourts: GetCourtsUseCase(),
                                       isUserInCourt: IsUserInCourtUseCase(),
                                       isUserInAnotherCourt: IsUserInAnotherCourtUseCase(),
                                       isCourtFull: IsCourtFullUseCase(),
                                       joinCourt: JoinCourtUseCase(),
                                       leaveCourt: LeaveCourtUseCase())
        controller.delegate = presenter
        navController = UINavigationController(rootViewController: controller)
        super.init()
        navController.delegate = self
        presenter.delegate = self
    }
}

extension CourtListWireframe: CourtListPresenterDelegate {
    func presentSignInUI() {
        let signInWireframe = SignInWireframe(authenticationService: authenticationService)
        signInWireframe.delegate = self
        self.signInWireframe = signInWireframe
        navController.present(signInWireframe.rootController, animated: true, completion: nil)
    }
    
    func presentChatUI(forCourtId id: Int) {
        let chatWireframe = ChatWireframe(courtId: id)
        self.chatWireframe = chatWireframe
        navController.pushViewController(chatWireframe.rootController, animated: true)
    }
}

extension CourtListWireframe: SignInWireframeDelegate {
    func signInUINeedsToBeDissmissed() {
        navController.dismiss(animated: true) { [weak self] in
            self?.signInWireframe = nil
        }
    }
}

extension CourtListWireframe: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        if viewController == controller {
            chatWireframe = nil
        }
    }
}
