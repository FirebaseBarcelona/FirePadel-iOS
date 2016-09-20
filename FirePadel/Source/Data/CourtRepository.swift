import Foundation
import RxSwift

protocol CourtRepository {
    func getCourts() -> Observable<[Court]>
    func join(user: User, to court: Court)
}
