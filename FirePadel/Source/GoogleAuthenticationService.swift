import Foundation
import GoogleSignIn
import RxSwift

final class GoogleAuthenticationService: NSObject {
    fileprivate let googleAuthentication = Variable<Authentication?>(nil)
    
    func start(clientId: String) {
        GIDSignIn.sharedInstance().clientID = clientId
        GIDSignIn.sharedInstance().delegate = self
        googleAuthentication.value = Authentication(from: GIDSignIn.sharedInstance().currentUser?.authentication)
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool{
        guard let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String else {
            return false
        }
        let annotation = options[UIApplicationOpenURLOptionsKey.annotation]
        
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
}

extension GoogleAuthenticationService: AuthenticationService {
    var authentication: Observable<Authentication?> {
        return googleAuthentication.asObservable()
    }
}

extension GoogleAuthenticationService: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            return
        }
        googleAuthentication.value = Authentication(from: user.authentication)
    }
}

fileprivate extension Authentication {
    init?(from googleAuthentication: GIDAuthentication?) {
        guard let googleAuthentication = googleAuthentication else {
            return nil
        }
        
        idToken = googleAuthentication.idToken
        accessToken = googleAuthentication.accessToken
    }
}
