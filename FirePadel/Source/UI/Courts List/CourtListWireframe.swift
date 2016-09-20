import UIKit

final class CourtListWireframe {
    private let controller = CourtListController()
    private let presenter: CourtListPresenter
    
    var rootController: UIViewController {
        return controller
    }
    
    init() {
        presenter = CourtListPresenter(ui: controller,
                                       getCourts: GetCourtsUseCase(),
                                       isUserInCourt: IsUserInCourtUseCase(),
                                       isUserInAnotherCourt: IsUserInAnotherCourtUseCase(),
                                       isCourtFull: IsCourtFullUseCase())
        controller.delegate = presenter
    }
}
