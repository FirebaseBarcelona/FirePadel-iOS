import Foundation
import RxSwift
import JSQMessagesViewController

final class ChatPresenter {
    fileprivate let ui: ChatUI
    fileprivate let getMessages: UseCase.GetMessagesForCourtWithId
    fileprivate let sendMessage: UseCase.SendMessageToCourtWithId
    fileprivate let courtId: Int
    fileprivate let disposeBag = DisposeBag()
    
    init(courtId: Int,
         ui: ChatUI,
         getMessages: @escaping UseCase.GetMessagesForCourtWithId,
         sendMessage: @escaping UseCase.SendMessageToCourtWithId) {
        self.courtId = courtId
        self.ui = ui
        self.getMessages = getMessages
        self.sendMessage = sendMessage
    }
}

extension ChatPresenter: ChatUIDelegate {
    func viewLoaded() {
        let (currentMessages, newMessages) = getMessages(courtId)
        
        currentMessages.observeOn(MainScheduler.instance).subscribe { [weak self] event in
            guard let messages = event.element else {
                return
            }
            let chatMessages = messages.map { message in
                return ChatMessage(from: message)
            }
            self?.ui.load(messages: chatMessages)
        }.addDisposableTo(disposeBag)
        
        newMessages.observeOn(MainScheduler.instance).skip(1).subscribe { [weak self] event in
            guard let message = event.element else {
                return
            }
            let chatMessage = ChatMessage(from: message)
            self?.ui.add(message: chatMessage)
        }.addDisposableTo(disposeBag)
    }
    
    func sendMessage(message: String) {
        sendMessage(message, courtId)
    }
}
