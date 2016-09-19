import Foundation
import RxSwift

final class SignInPresenter {
    private let ui: SignInUI
    fileprivate let signInUseCase: UseCase.SignIn
    fileprivate let disposeBag = DisposeBag()
    
    init(ui: SignInUI, signInUseCase: @escaping UseCase.SignIn) {
        self.ui = ui
        self.signInUseCase = signInUseCase
        self.ui.delegate = self
    }
}

extension SignInPresenter: SignInUIDelegate {
    func viewLoaded() {
        signInUseCase().subscribe { user in
            print(user.element)
        }.addDisposableTo(disposeBag)
    }
}
