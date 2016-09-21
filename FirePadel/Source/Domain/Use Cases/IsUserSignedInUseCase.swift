import Foundation

func IsUserSignedInUseCase(signInService: SignInService = FirebaseSignInService()) -> UseCase.IsUserSignedIn {
    return signInService.isUserSignedIn
}
