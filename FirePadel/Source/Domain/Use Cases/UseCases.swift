import Foundation
import RxSwift

struct UseCase {
    typealias IsUserSignedIn = () -> Bool
    typealias SignIn = () -> Observable<User>
    typealias GetCurrentUser = () -> User?
    typealias GetCourts = () -> Observable<[Court]>
    typealias IsUserInCourt = (Court) -> Bool
    typealias IsUserInAnotherCourt = (Court, _ allCourts: [Court]) -> Bool
}
