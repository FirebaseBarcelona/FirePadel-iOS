import UIKit

final class ChatWireframe {
    private let controller = ChatController()
    private let presenter: ChatPresenter
    
    var rootController: UIViewController {
        return controller
    }
    
    init() {
        let getCurrentUser = GetCurrentUserUseCase()
        let user = getCurrentUser()
        
        controller.userUid = user?.uid
        controller.userDisplayName = user?.displayName
        
        presenter = ChatPresenter(courtId: 2,
                                  ui: controller,
                                  getMessages: GetMessagesForCourtWithIdUseCase())
        controller.delegate = presenter
    }
}
