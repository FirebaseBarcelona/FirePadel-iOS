import Foundation
import RxSwift

final class CourtListPresenter {
    fileprivate let ui: CourtListUI
    fileprivate let getCourts: UseCase.GetCourts
    fileprivate let isUserInCourt: UseCase.IsUserInCourt
    fileprivate let isUserInAnotherCourt: UseCase.IsUserInAnotherCourt
    fileprivate let isCourtFull: UseCase.IsCourtFull
    fileprivate let joinCourt: UseCase.JoinCourtUseCase
    fileprivate let disposeBag = DisposeBag()
    
    init(ui: CourtListUI,
         getCourts: @escaping UseCase.GetCourts,
         isUserInCourt: @escaping UseCase.IsUserInCourt,
         isUserInAnotherCourt: @escaping UseCase.IsUserInAnotherCourt,
         isCourtFull: @escaping UseCase.IsCourtFull,
         joinCourt: @escaping UseCase.JoinCourtUseCase) {
        self.ui = ui
        self.getCourts = getCourts
        self.isUserInCourt = isUserInCourt
        self.isUserInAnotherCourt = isUserInAnotherCourt
        self.isCourtFull = isCourtFull
        self.joinCourt = joinCourt
        self.ui.delegate = self
    }
}

extension CourtListPresenter: CourtListUIDelegate {
    func viewLoaded() {
        getCourts().map { courts -> [CourtState] in
            return courts.map { court in
                let players = court.players.map { user in
                    return PlayersView.Player(name: user.displayName ,avatarURL: user.photoURL)
                }
                
                let state: CourtActionButtons.State = {
                    if self.isUserInCourt(court) {
                        return .leaveOrChat
                    } else if self.isUserInAnotherCourt(court, courts) {
                        return .none
//                    } else if self.isCourtFull(court) {
//                        return .none
                    } else {
                        return .join
                    }
                }()
                
                return CourtState(players: players,
                                  actionButtonsState: state)
            }
        }.observeOn(MainScheduler.instance).subscribe { event in
            guard let courts = event.element else {
                return
            }
            self.ui.courts = courts
        }.addDisposableTo(disposeBag)
    }
}
