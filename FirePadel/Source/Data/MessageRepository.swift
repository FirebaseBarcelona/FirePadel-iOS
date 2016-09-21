import Foundation
import RxSwift

protocol MessageRepository {
    func getMessages(forCourtId id: Int) -> (current: Observable<[Message]>, new: Observable<Message>)
    func send(message: Message, toCourtId id: Int)
}
