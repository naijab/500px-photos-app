import Foundation
import RxSwift
import RxAlamofire
import ObjectMapper

final class PhotosAPIService {

    static let shared = PhotosAPIService()

    func getPhotos() -> Observable<[PhotosEntity]?> {
        return RxAlamofire
            .requestJSON(.get, APIConstant.shared.apiPhotosBaseURL)
            .map { (response, value) in
                guard response.statusCode == 200 else { return nil }

                let dataRaw = value as! [String: Any]
                let data = Mapper<APIPhotosResponse>().map(JSONObject: dataRaw)
                return data?.photos
            }
            .asObservable()
    }

}
