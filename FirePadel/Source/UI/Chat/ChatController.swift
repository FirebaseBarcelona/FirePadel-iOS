import UIKit
import RxSwift
import JSQMessagesViewController
import Haneke

final class ChatController: JSQMessagesViewController, ChatUI {
    typealias Message = ChatMessage
    
    private var messages = [Message]()
    private var avatars = [String : JSQMessagesAvatarImage]()
    
    var userDisplayName: String?
    var userUid: String?
    var delegate: ChatUIDelegate?
    
    func load(messages: [Message]) {
        self.messages = messages
        collectionView?.reloadData()
    }
    
    func add(message: Message) {
        messages.append(message)
        finishReceivingMessage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputToolbar.contentView?.leftBarButtonItem = nil
        title = "Chat"
        delegate?.viewLoaded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.contentInset.top = topLayoutGuide.length
    }
    
    // MARK: - JSQMessagesViewController
    
    override func didPressSend(_ button: UIButton,
                               withMessageText text: String,
                               senderId: String,
                               senderDisplayName: String,
                               date: Date) {
        delegate?.sendMessage(message: text)
        finishSendingMessage()
    }
    
    override func senderDisplayName() -> String {
        return userDisplayName ?? ""
    }
    
    override func senderId() -> String {
        return userUid ?? ""
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView,
                                 messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, didDeleteMessageAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource? {
        let message = messages[indexPath.item]
        
        if message.userUid == senderId() {
            return JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
        } else {
            return JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView,
                                 avatarImageDataForItemAt indexPath: IndexPath) -> JSQMessageAvatarImageDataSource? {
        let message = messages[indexPath.item]
        
        if let avatar = avatars[message.userUid] {
            return avatar
        }
        
        _ = Shared.imageCache.fetch(URL: message.userAvatar).onSuccess { [weak self] image in
            let avatar = JSQMessagesAvatarImageFactory().avatarImage(with: image)
            self?.avatars[message.userUid] = avatar
            self?.collectionView?.reloadItems(at: [indexPath])
        }
        
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
}
