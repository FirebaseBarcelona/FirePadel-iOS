import Foundation

protocol SignInUI {
    weak var delegate: SignInUIDelegate? { get set }
}

protocol SignInUIDelegate: class {
    func viewLoaded()
}
