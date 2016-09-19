import Foundation
import RxSwift

func SignInUseCase(signInService: SignInService,
                   authenticationService: AuthenticationService) -> UseCase.SignIn {
    return authenticationService.authentication.skipWhile { authentication in
        return authentication == nil
    }.flatMap { authentication -> Observable<User> in
        return signInService.signIn(with: authentication!)
    }.asObservable
}
