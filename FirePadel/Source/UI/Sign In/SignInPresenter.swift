import Foundation
import RxSwift

protocol SignInPresenterDelegate: class {
    func signInFinished()
}

final class SignInPresenter {
    weak var delegate: SignInPresenterDelegate?
    
    private let ui: SignInUI
    fileprivate let signInUseCase: UseCase.SignIn
    fileprivate let disposeBag = DisposeBag()
    
    init(ui: SignInUI, signInUseCase: @escaping UseCase.SignIn) {
        self.ui = ui
        self.signInUseCase = signInUseCase
    }
}

extension SignInPresenter: SignInUIDelegate {
    func viewLoaded() {
        signInUseCase().subscribe { [weak self] user in
            if user.element != nil {
                self?.delegate?.signInFinished()
            }
        }.addDisposableTo(disposeBag)
    }
}
