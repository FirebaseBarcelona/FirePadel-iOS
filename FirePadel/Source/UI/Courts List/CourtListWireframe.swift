import UIKit

final class CourtListWireframe {
    private let getCourtsUseCase = GetCourtsUseCase()
    private let controller = CourtListController()
    private let presenter: CourtListPresenter
    
    var rootController: UIViewController {
        return controller
    }
    
    init() {
        presenter = CourtListPresenter(ui: controller,
                                       getCourtsUseCase: getCourtsUseCase)
        controller.delegate = presenter
    }
}
