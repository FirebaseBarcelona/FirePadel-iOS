import Foundation
import FirebaseDatabase
import RxSwift

final class CourtFirebaseDataSource: CourtRepository {
    static private let courtsChildPath = "courts"
    
    func getCourts() -> Observable<[Court]> {
        return Observable.create { observer in
            let database = self.getFirebaseDatabaseReference()
            
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
    
    private func getFirebaseDatabaseReference() -> FIRDatabaseReference {
        return FIRDatabase.database().reference().child(CourtFirebaseDataSource.courtsChildPath)
    }
}
