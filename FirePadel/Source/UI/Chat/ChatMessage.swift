import Foundation
import JSQMessagesViewController

class ChatMessage: NSObject {
    let messageText: String
    let userUid: String
    let userName: String
    let userAvatar: URL
    fileprivate let messageDate = Date()
    
    init(text: String, userUid: String, userName: String, userAvatar: URL) {
        self.messageText = text
        self.userUid = userUid
        self.userName = userName
        self.userAvatar = userAvatar
        super.init()
    }
}

extension ChatMessage: JSQMessageData {
    func senderId() -> String {
        return userUid
    }
    
    func senderDisplayName() -> String {
        return userName
    }
    
    func date() -> Date {
        return messageDate
    }
    
    
    func isMediaMessage() -> Bool {
        return false
    }
    
    func messageHash() -> UInt {
        let textHash = messageText.hashValue
        let userHash = userUid.hashValue
        let dateHash = messageDate.hashValue
        return UInt(abs( userHash ^ dateHash ^ textHash ))
    }
    
    public func text() -> String {
        return messageText
    }
    
    func media() -> JSQMessageMediaData {
        return JSQPhotoMediaItem()
    }
}

extension ChatMessage {
    convenience init(from message: Message) {
        self.init(text: message.text,
                  userUid: message.userUid,
                  userName: message.userName,
                  userAvatar: message.userAvatar)
    }
}
