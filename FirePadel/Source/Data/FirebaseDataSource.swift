import Foundation
import FirebaseDatabase

final class FirebaseDataSource {
    static private let courtsPath = "courts"
    
    static let databaseReference = FIRDatabase.database().reference()
    
    static func getCourtsNodeReference() -> FIRDatabaseQuery {
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
        return FirebaseDataSource.courtsPath + "/court\(id)"
    }
    
    static private func messagesDatabasePath(courtId id: Int) -> String {
        return databasePath(courtId: id) + "/messages"
    }
    
    static private func getNodeReference(path: String) -> FIRDatabaseReference {
        return databaseReference.child(path)
    }
}
