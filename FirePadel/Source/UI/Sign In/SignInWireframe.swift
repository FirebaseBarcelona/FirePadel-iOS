import UIKit

final class SignInWireframe {
    let rootController: UIViewController = {
        let view = SignInView()
        let controller = SignInController(view: view)
        return controller
    }()
}
