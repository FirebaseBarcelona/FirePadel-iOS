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
        let courtListView = CourtListView()
        courtListView.joinButtonAction = delegate?.joinAction
        courtListView.leaveButtonAction = delegate?.leaveAction
        courtListView.chatButtonAction = delegate?.chatAction
        view = courtListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.viewLoaded()
    }
}
