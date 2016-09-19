import Foundation

func IsUserSignedInUseCase(signInService: SignInService) -> UseCase.IsUserSignedIn {
    return signInService.isUserSignedIn
}
