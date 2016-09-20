import Foundation
import RxSwift

protocol CourtRepository {
    func getCourts() -> Observable<[Court]>
}
