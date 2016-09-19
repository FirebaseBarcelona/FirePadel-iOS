import Foundation
import Firebase
import RxSwift

final class FirebaseSignInService: SignInService {
    func isUserSignedIn() -> Bool {
        return false
    }
    
    func signIn(with authentication: Authentication) -> Observable<User> {
        return Observable.create { observer in
            let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                              accessToken: authentication.accessToken)
            FIRAuth.auth()?.signIn(with: credential) { firebaseUser, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let firebaseUser = firebaseUser,
                    let user = User(from: firebaseUser) else {
                        observer.onError(SignInError.invalidUser)
                        return
                }
                
                observer.onNext(user)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}

fileprivate extension User {
    init?(from firebaseUser: FIRUser) {
        guard let displayName = firebaseUser.displayName,
            let email = firebaseUser.email,
            let photoURL = firebaseUser.photoURL else {
                return nil
        }
        
        uid = firebaseUser.uid
        self.displayName = displayName
        self.email = email
        self.photoURL = photoURL
    }
}
