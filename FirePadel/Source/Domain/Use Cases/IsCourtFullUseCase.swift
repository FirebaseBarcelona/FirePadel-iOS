import Foundation

let MaxNumberOfPlayersPerCourt = 4

func IsCourtFullUseCase() -> UseCase.IsCourtFull {
    let useCase: UseCase.IsCourtFull = { court in
        return court.players.count >= MaxNumberOfPlayersPerCourt
    }
    return useCase
}
