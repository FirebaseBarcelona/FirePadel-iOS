import Foundation
import RxSwift

protocol AuthenticationService {
    var authentication: Observable<Authentication?> { get }
}
