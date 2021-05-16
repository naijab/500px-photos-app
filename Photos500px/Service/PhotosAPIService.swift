import Foundation
import Alamofire
import RxSwift
import RxAlamofire
import ObjectMapper

protocol IPhotosAPIService {
    func getPhotos(page: Int) -> Observable<APIPhotosResponse?>
}

final class PhotosAPIService: IPhotosAPIService {

    func getPhotos(page: Int = 1) -> Observable<APIPhotosResponse?> {

        let parameters: Parameters = [
            "feature": "popular",
            "page": page,
            "rpp": 20
        ]

        return RxAlamofire
            .requestJSON(.get, APIConstant.shared.apiPhotosBaseURL, parameters: parameters)
            .map { (response, value) in
                guard response.statusCode == 200 else { return nil }
                let dataRaw = value as! [String: Any]
                return Mapper<APIPhotosResponse>().map(JSONObject: dataRaw)
            }
            .asObservable()
    }

}
