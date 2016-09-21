import UIKit

final class MainWireframe {
    private let window = UIWindow(frame: UIScreen.main.bounds)
    private let courtListWireframe: CourtListWireframe
    
    let googleAuthenticationService = GoogleAuthenticationService()
    
    init() {
        courtListWireframe = CourtListWireframe(authenticationService: googleAuthenticationService)
    }
    
    func setupKeyWindow() -> UIWindow {
        window.rootViewController = courtListWireframe.rootController
        window.makeKeyAndVisible()
        return window
    }
}
