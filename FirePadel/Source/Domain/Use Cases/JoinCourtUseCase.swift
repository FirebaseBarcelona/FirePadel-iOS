import Foundation

func JoinCourtUseCase(courtRepository: CourtRepository = CourtFirebaseDataSource(),
                      getCurrentUser: @escaping UseCase.GetCurrentUser = GetCurrentUserUseCase())
    -> UseCase.JoinCourtUseCase {
        let useCase: UseCase.JoinCourtUseCase = { court in
            guard let user = getCurrentUser() else {
                return
            }
            return courtRepository.join(user: user, to: court)
        }
        return useCase
}
