import Foundation
import RxSwift

protocol CourtListPresenterDelegate: class {
    func presentSignInUI()
    func presentChatUI(forCourtId id: Int)
}

final class CourtListPresenter {
    weak var delegate: CourtListPresenterDelegate?
    
    fileprivate let ui: CourtListUI
    fileprivate let isUserSignedIn: UseCase.IsUserSignedIn
    fileprivate let getCourts: UseCase.GetCourts
    fileprivate let isUserInCourt: UseCase.IsUserInCourt
    fileprivate let isUserInAnotherCourt: UseCase.IsUserInAnotherCourt
    fileprivate let isCourtFull: UseCase.IsCourtFull
    fileprivate let joinCourt: UseCase.JoinCourtUseCase
    fileprivate let leaveCourt: UseCase.LeaveCourtUseCase
    
    fileprivate let courts = Variable([Court]())
    fileprivate let disposeBag = DisposeBag()
    
    init(ui: CourtListUI,
         isUserSignedIn: @escaping UseCase.IsUserSignedIn,
         getCourts: @escaping UseCase.GetCourts,
         isUserInCourt: @escaping UseCase.IsUserInCourt,
         isUserInAnotherCourt: @escaping UseCase.IsUserInAnotherCourt,
         isCourtFull: @escaping UseCase.IsCourtFull,
         joinCourt: @escaping UseCase.JoinCourtUseCase,
         leaveCourt: @escaping UseCase.LeaveCourtUseCase) {
        self.ui = ui
        self.isUserSignedIn = isUserSignedIn
        self.getCourts = getCourts
        self.isUserInCourt = isUserInCourt
        self.isUserInAnotherCourt = isUserInAnotherCourt
        self.isCourtFull = isCourtFull
        self.joinCourt = joinCourt
        self.leaveCourt = leaveCourt
    }
}

extension CourtListPresenter: CourtListUIDelegate {
    func viewLoaded() {
        let courts = getCourts().share()
        
        courts.map { courts -> [CourtState] in
            return courts.map { court in
                let players = court.players.map { user in
                    return PlayersView.Player(name: user.displayName ,avatarURL: user.photoURL)
                }
                
                let state: CourtActionButtons.State = {
                    if self.isUserInCourt(court) {
                        return .leaveOrChat
                    } else if self.isUserInAnotherCourt(court, courts) {
                        return .none
                    } else if self.isCourtFull(court) {
                        return .none
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
        
        courts.bindTo(self.courts).addDisposableTo(disposeBag)
    }
    
    func viewAppeared() {
        if !isUserSignedIn() {
            delegate?.presentSignInUI()
        }
    }
    
    func joinAction(forCourtAt index: Int) {
        let court = courts.value[index]
        joinCourt(court)
    }
    
    func leaveAction(forCourtAt index: Int) {
        let court = courts.value[index]
        leaveCourt(court)
    }
    
    func chatAction(forCourtAt index: Int) {
        delegate?.presentChatUI(forCourtId: index)
    }
}
