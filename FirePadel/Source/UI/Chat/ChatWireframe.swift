import UIKit

final class ChatWireframe {
    private let controller = ChatController()
    private let presenter: ChatPresenter
    
    var rootController: UIViewController {
        return controller
    }
    
    init() {
        presenter = ChatPresenter(courtId: 2,
                                  ui: controller,
                                  getMessages: GetMessagesForCourtWithIdUseCase())
        controller.delegate = presenter
    }
}
