import Foundation
import RxSwift

final class CourtListPresenter {
    fileprivate let ui: CourtListUI
    fileprivate let getCourts: UseCase.GetCourts
    fileprivate let disposeBag = DisposeBag()
    
    init(ui: CourtListUI,
         getCourtsUseCase: @escaping UseCase.GetCourts) {
        self.ui = ui
        self.getCourts = getCourtsUseCase
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
                
                return CourtState(players: players,
                                  actionButtonsState: .join)
            }
        }.observeOn(MainScheduler.instance).subscribe { event in
            guard let courts = event.element else {
                return
            }
            self.ui.courts = courts
        }.addDisposableTo(disposeBag)
    }
}
