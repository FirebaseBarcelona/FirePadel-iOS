import Foundation

func IsUserInAnotherCourtUseCase(getCurrentUser: @escaping UseCase.GetCurrentUser = GetCurrentUserUseCase())
    -> UseCase.IsUserInAnotherCourt {
        let useCase: UseCase.IsUserInAnotherCourt = { court, allCourts in
            guard let currentUser = getCurrentUser() else {
                return false
            }
            
            let anotherCourts = allCourts.filter { anotherCourt in
                return court.id != anotherCourt.id
            }
            
            for court in anotherCourts {
                let currentUserIsInCourt = court.players.contains { user in
                    user.uid == currentUser.uid
                }
                
                if currentUserIsInCourt {
                    return true
                }
            }
            
            return false
        }
        return useCase
}
