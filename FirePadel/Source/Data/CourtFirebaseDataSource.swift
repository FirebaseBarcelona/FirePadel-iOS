import Foundation
import FirebaseDatabase
import RxSwift

final class CourtFirebaseDataSource: CourtRepository {
    static private let courtsChildPath = "courts"
    static private let courtOneChildPath = "courts/court1"
    static private let courtTwoChildPath = "courts/court2"
    
    private let databaseReference = FIRDatabase.database().reference()
    
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
    
    func join(user: User, to court: Court) {
        let courtNode = self.getFirebaseNodeReference(court: court)
        let key = user.uid
        let user = user.toJSON()
        let update = ["users/\(key)": user]
        courtNode.updateChildValues(update)
    }
    
    func leave(user: User, from court: Court) {
        let courtNode = self.getFirebaseNodeReference(court: court)
        let key = user.uid
        courtNode.child("users/\(key)").removeValue()
    }
    
    private func getFirebaseDatabaseReference() -> FIRDatabaseReference {
        return databaseReference.child(CourtFirebaseDataSource.courtsChildPath)
    }
    
    private func getFirebaseNodeReference(court: Court) -> FIRDatabaseReference {
        let courtPath = databasePath(court: court)
        return getFirebaseNodeReference(path: courtPath)
    }
    
    private func databasePath(court: Court) -> String {
        if court.id == 1 {
            return CourtFirebaseDataSource.courtOneChildPath
        } else {
            return CourtFirebaseDataSource.courtTwoChildPath
        }
    }
    
    private func getFirebaseNodeReference(path: String) -> FIRDatabaseReference {
        return databaseReference.child(path)
    }
}
