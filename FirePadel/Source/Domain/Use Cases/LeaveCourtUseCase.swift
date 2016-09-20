import Foundation

func LeaveCourtUseCase(courtRepository: CourtRepository = CourtFirebaseDataSource(),
                       getCurrentUser: @escaping UseCase.GetCurrentUser = GetCurrentUserUseCase())
    -> UseCase.LeaveCourtUseCase {
        let useCase: UseCase.LeaveCourtUseCase = { court in
            guard let user = getCurrentUser() else {
                return
            }
            return courtRepository.leave(user: user, from: court)
        }
        return useCase
}
