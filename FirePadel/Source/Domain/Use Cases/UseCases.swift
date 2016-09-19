import Foundation
import RxSwift

struct UseCase {
    typealias IsUserSignedIn = () -> Bool
    typealias SignIn = () -> Observable<User>
}
