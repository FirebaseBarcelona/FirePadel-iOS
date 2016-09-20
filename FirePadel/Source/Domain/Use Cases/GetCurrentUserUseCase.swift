import Foundation

func GetCurrentUserUseCase(signInService: SignInService = FirebaseSignInService()) -> UseCase.GetCurrentUser {
    return signInService.currentUser
}
