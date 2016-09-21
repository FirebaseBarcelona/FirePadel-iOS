import Foundation

func GetMessagesForCourtWithIdUseCase(messageRepository: MessageRepository = MessageFirebaseDataSource()) -> UseCase.GetMessagesForCourtWithId {
    return messageRepository.getMessages
}
