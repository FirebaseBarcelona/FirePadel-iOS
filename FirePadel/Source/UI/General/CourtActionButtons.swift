import UIKit
import RxSwift
import RxCocoa

final class CourtActionButtons: UIStackView {
    
    typealias ButtonAction = (Void) -> Void
    
    enum State {
        case join, leaveOrChat, none
    }
    
    static private let subviewSpacing: CGFloat = 8
    
    private let joinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("JOIN", for: .normal)
        return button
    }()
    
    private let leaveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LEAVE", for: .normal)
        button.isHidden = true
        return button
    }()
    
    private let chatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CHAT", for: .normal)
        button.isHidden = true
        return button
    }()
    
    var state: State {
        get {
            return observableState.value
        }
        set {
            observableState.value = newValue
        }
    }
    
    var joinButtonAction: ButtonAction?
    var leaveButtonAction: ButtonAction?
    var chatButtonAction: ButtonAction?
    
    private let observableState = Variable<State>(.join)
    private let disposeBag = DisposeBag()
    
    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View setup
    
    private func setup() {
        addSubviews()
        configureLayout()
        setupBindings()
    }
    
    private func addSubviews() {
        addArrangedSubview(chatButton)
        addArrangedSubview(leaveButton)
        addArrangedSubview(joinButton)
    }
    
    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        spacing = CourtActionButtons.subviewSpacing
    }
    
    private func setupBindings() {
        setupStateBindings()
        setupButtonBindings()
    }
    
    private func setupStateBindings() {
        let isJoinState = observableState.asDriver().map { state in
            return state == .join
        }
        
        let isLeaveOrChatState = observableState.asDriver().map { state in
            return state == .leaveOrChat
        }
        
        isJoinState.map(!).drive(joinButton.rx.hidden).addDisposableTo(disposeBag)
        isLeaveOrChatState.map(!).drive(chatButton.rx.hidden).addDisposableTo(disposeBag)
        isLeaveOrChatState.map(!).drive(leaveButton.rx.hidden).addDisposableTo(disposeBag)
    }
    
    private func setupButtonBindings() {
        joinButton.rx.tap.subscribe { [weak self] _ in
            self?.joinButtonAction?()
        }.addDisposableTo(disposeBag)
        leaveButton.rx.tap.subscribe { [weak self] _ in
            self?.leaveButtonAction?()
        }.addDisposableTo(disposeBag)
        chatButton.rx.tap.subscribe { [weak self] _ in
            self?.chatButtonAction?()
        }.addDisposableTo(disposeBag)
    }
}
