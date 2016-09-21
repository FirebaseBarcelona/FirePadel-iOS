import UIKit

final class ChatWireframe {
    private let controller = ChatController()
    private let presenter: ChatPresenter
    
    var rootController: UIViewController {
        return controller
    }
    
    init(courtId: Int) {
        let getCurrentUser = GetCurrentUserUseCase()
        let user = getCurrentUser()
        
        controller.userUid = user?.uid
        controller.userDisplayName = user?.displayName
        
        presenter = ChatPresenter(courtId: courtId,
                                  ui: controller,
                                  getMessages: GetMessagesForCourtWithIdUseCase(),
                                  sendMessage: SendMessageToCourtWithIdUseCase())
        controller.delegate = presenter
    }
}
