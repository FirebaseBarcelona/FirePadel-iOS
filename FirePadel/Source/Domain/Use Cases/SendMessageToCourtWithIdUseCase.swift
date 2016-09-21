import Foundation

func SendMessageToCourtWithIdUseCase(messageRepository: MessageRepository = MessageFirebaseDataSource(),
                                     getUser: @escaping UseCase.GetCurrentUser = GetCurrentUserUseCase()
                                     )
    -> UseCase.SendMessageToCourtWithId {
        let useCase: UseCase.SendMessageToCourtWithId = { message, courtId in
            guard let user = getUser() else { return }
            let message = Message(text: message,
                                  userUid: user.uid,
                                  userName: user.displayName,
                                  userAvatar: user.photoURL)
            messageRepository.send(message: message, toCourtId: courtId)
        }
        return useCase
}
