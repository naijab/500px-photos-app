import Foundation
import Alamofire
import RxSwift
import RxAlamofire
import ObjectMapper

final class PhotosAPIService {

    static let shared = PhotosAPIService()

    func getPhotos(page: Int = 1) -> Observable<APIPhotosResponse?> {

        let parameters: Parameters = [
            "feature": "popular",
            "page": 1
        ]

        return RxAlamofire
            .requestJSON(.get, APIConstant.shared.apiPhotosBaseURL, parameters: parameters)
            .map { (response, value) in
                guard response.statusCode == 200 else { return nil }
                print("Fetch API!")
                let dataRaw = value as! [String: Any]
                return Mapper<APIPhotosResponse>().map(JSONObject: dataRaw)
            }
            .asObservable()
    }

}
