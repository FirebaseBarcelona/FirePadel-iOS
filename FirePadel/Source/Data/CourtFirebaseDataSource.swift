import Foundation
import FirebaseDatabase
import RxSwift

final class CourtFirebaseDataSource: CourtRepository {
    func getCourts() -> Observable<[Court]> {
        return Observable.create { observer in
            let database = FirebaseDataSource.getCourtsNodeReference()
            
            let handle = database.observe(.value, with: { snapshot in
                guard let json = snapshot.value as? [String : AnyObject] else {
                    return
                }
                
                let courts: [Court] = Court.array(from: json)
                
                observer.onNext(courts)
            })
            
            return Disposables.create {
                database.removeObserver(withHandle: handle)
            }
        }
    }
    
    func join(user: User, to court: Court) {
        let courtNode = FirebaseDataSource.getCourtNodeReference(id: court.id)
        let key = user.uid
        let user = user.toJSON()
        let update = ["users/\(key)": user]
        courtNode.updateChildValues(update)
    }
    
    func leave(user: User, from court: Court) {
        let courtNode = FirebaseDataSource.getCourtNodeReference(id: court.id)
        let key = user.uid
        courtNode.child("users/\(key)").removeValue()
    }
}
