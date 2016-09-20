import Foundation
import FirebaseDatabase
import RxSwift

func GetCourtsUseCase(courtRepository: CourtRepository = CourtFirebaseDataSource()) -> UseCase.GetCourts {
    return courtRepository.getCourts
}
