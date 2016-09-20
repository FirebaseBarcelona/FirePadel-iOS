import Foundation

func IsUserInCourtUseCase(getCurrentUser: @escaping UseCase.GetCurrentUser = GetCurrentUserUseCase())
    -> UseCase.IsUserInCourt {
        let useCase: UseCase.IsUserInCourt = { court in
            guard let currentUser = getCurrentUser() else {
                return false
            }
            
            return court.players.contains { user in
                user.uid == currentUser.uid
            }
        }
        return useCase
}
