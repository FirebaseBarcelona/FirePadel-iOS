import Foundation

typealias CourtState = CourtListView.CourtState

protocol CourtListUI: class {
    weak var delegate: CourtListUIDelegate? { get set }
    var courts: [CourtState] { get set }
}

protocol CourtListUIDelegate: class {
    func viewLoaded()
}
