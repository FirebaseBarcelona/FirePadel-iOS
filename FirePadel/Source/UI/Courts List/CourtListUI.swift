import Foundation

typealias CourtState = CourtListView.CourtState

protocol CourtListUI: class {
    weak var delegate: CourtListUIDelegate? { get set }
    var courts: [CourtState] { get set }
}

protocol CourtListUIDelegate: class {
    func viewLoaded()
    func joinAction(forCourtAt index: Int)
    func leaveAction(forCourtAt index: Int)
    func chatAction(forCourtAt index: Int)
}
