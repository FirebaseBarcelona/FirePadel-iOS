import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let mainWireframe = MainWireframe()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseService.start()
        mainWireframe.googleAuthenticationService.start(clientId: FirebaseService.clientId)
        window = mainWireframe.setupKeyWindow()
        
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return mainWireframe.googleAuthenticationService.application(app, open: url, options: options)
    }
}
