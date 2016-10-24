import Foundation
import FirebaseDatabase
import RxSwift

final class CourtFirebaseDataSource: CourtRepository {
    func getCourts() -> Observable<[Court]> {
        return Observable.create { observer in
            let database = FirebaseDataSource.getCourtsNodeReference()
            
            let handle = database.observe(.value, with: { snapshot in
                let courts: [Court] = snapshot.children.allObjects.flatMap { childSnapshot in
                    guard let courtJson = (childSnapshot as? FIRDataSnapshot)?.value as? [String : AnyObject] else {
                        return nil
                    }
                    return Court(from: courtJson)
                }
                
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
