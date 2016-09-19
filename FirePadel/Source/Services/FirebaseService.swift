import Foundation
import Firebase
import RxSwift

final class FirebaseService {
    static var clientId: String {
        return FIRApp.defaultApp()?.options.clientID ?? ""
    }
    
    static func start() {
        FIRApp.configure()
    }
}
