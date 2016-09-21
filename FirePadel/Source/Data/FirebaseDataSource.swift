import Foundation
import FirebaseDatabase

final class FirebaseDataSource {
    static private let courtsPath = "courts"
    static private let courtOnePath = "courts/court1"
    static private let courtTwoPath = "courts/court2"
    
    static let databaseReference = FIRDatabase.database().reference()
    
    static func getCourtsNodeReference() -> FIRDatabaseReference {
        return getNodeReference(path: courtsPath)
    }
    
    static func getCourtNodeReference(id: Int) -> FIRDatabaseReference {
        let courtPath = databasePath(courtId: id)
        return getNodeReference(path: courtPath)
    }
    
    static func getMessagedNodeReference(forCourtId id: Int) -> FIRDatabaseReference {
        let messagesPath = messagesDatabasePath(courtId: id)
        return getNodeReference(path: messagesPath)
    }
    
    static private func databasePath(courtId id: Int) -> String {
        if id == 1 {
            return FirebaseDataSource.courtOnePath
        } else {
            return FirebaseDataSource.courtTwoPath
        }
    }
    
    static private func messagesDatabasePath(courtId id: Int) -> String {
        return databasePath(courtId: id) + "/messages"
    }
    
    static private func getNodeReference(path: String) -> FIRDatabaseReference {
        return databaseReference.child(path)
    }
}
