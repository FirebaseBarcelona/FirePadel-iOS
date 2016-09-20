import Foundation

func GetCurrentUserUseCase(signInService: SignInService) -> UseCase.GetCurrentUser {
    return signInService.currentUser
}
