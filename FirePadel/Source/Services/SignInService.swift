import Foundation
import RxSwift

protocol SignInService {
    func isUserSignedIn() -> Bool
    func currentUser() -> User?
    func signIn(with authentication: Authentication) -> Observable<User>
}

enum SignInError: Error {
    case invalidUser
}
