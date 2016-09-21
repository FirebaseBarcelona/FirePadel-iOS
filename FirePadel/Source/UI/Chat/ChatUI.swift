import Foundation

protocol ChatUI: class {
    weak var delegate: ChatUIDelegate? { get set }
    
    func load(messages: [ChatMessage])
    func add(message: ChatMessage)
}

protocol ChatUIDelegate: class {
    func viewLoaded()
    func sendMessage(message: String)
}
