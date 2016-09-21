import Foundation
import RxSwift

struct UseCase {
    typealias IsUserSignedIn = () -> Bool
    typealias SignIn = () -> Observable<User>
    typealias GetCurrentUser = () -> User?
    typealias GetCourts = () -> Observable<[Court]>
    typealias IsUserInCourt = (Court) -> Bool
    typealias IsUserInAnotherCourt = (Court, _ allCourts: [Court]) -> Bool
    typealias IsCourtFull = (Court) -> Bool
    typealias JoinCourtUseCase = (Court) -> Void
    typealias LeaveCourtUseCase = (Court) -> Void
    typealias GetMessagesForCourtWithId = (Int) -> (Observable<[Message]>, Observable<Message>)
}
