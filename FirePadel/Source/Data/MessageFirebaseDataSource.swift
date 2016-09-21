import Foundation
import FirebaseDatabase
import RxSwift

final class MessageFirebaseDataSource: MessageRepository {
    func getMessages(forCourtId id: Int) -> (current: Observable<[Message]>, new: Observable<Message>) {
        let messagesNode = FirebaseDataSource.getMessagedNodeReference(forCourtId: id)
        
        let current: Observable<[Message]> = Observable.create { observer in
            messagesNode.observeSingleEvent(of: .value, with: { snapshot in
                let messages: [Message] = snapshot.children.allObjects.flatMap { child in
                    guard let snapshot = child as? FIRDataSnapshot,
                        let json = snapshot.value as? [String : AnyObject] else {
                        return nil
                    }
                    return Message(from: json)
                }
                observer.onNext(messages)
                observer.onCompleted()
            })
            
            return Disposables.create()
        }
        
        let new: Observable<Message> = Observable.create { observer in
            let handle = messagesNode.queryLimited(toLast: 1).observe(.childAdded, with: { snapshot in
                guard let json = snapshot.value as? [String : AnyObject] else { return }
                if let message = Message(from: json) {
                    observer.onNext(message)
                }
            })
            
            return Disposables.create {
                messagesNode.removeObserver(withHandle: handle)
            }
        }
        
        return (current, new)
    }
    
    func send(message: Message, toCourtId id: Int) {
        let messagesNode = FirebaseDataSource.getMessagedNodeReference(forCourtId: id)
        messagesNode.childByAutoId().setValue(message.toJSON())
    }
}
