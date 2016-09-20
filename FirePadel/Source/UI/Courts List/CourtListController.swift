import UIKit
import RxSwift
import FirebaseDatabase

final class CourtListController: UIViewController, CourtListUI {
    
    weak var delegate: CourtListUIDelegate?
    
    var courts: [CourtState] {
        get {
            return courtListView.courts
        }
        set {
            courtListView.courts = newValue
        }
    }
    
    private var courtListView: CourtListView {
        return view as! CourtListView
    }
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = CourtListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.viewLoaded()
    }
}
