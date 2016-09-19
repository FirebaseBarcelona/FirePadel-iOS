import Foundation
import RxSwift

protocol SignInService {
    func isUserSignedIn() -> Bool
    func signIn(with authentication: Authentication) -> Observable<User>
}

enum SignInError: Error {
    case invalidUser
}
