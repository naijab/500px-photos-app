import Foundation
import RxSwift
import ObjectMapper

final class MockPhotosAPIService: IPhotosAPIService {

    func getPhotos(page: Int) -> Observable<APIPhotosResponse?> {
        let mockMap = [
            "current_page": "1",
            "total_pages": "10",
            "photos": [
                [
                    "id": 1,
                    "url": "/someting",
                    "name": "Mock 1",
                    "description": "Mock Description",
                    "image_url": [
                        [
                            "https://picsum.photos/200/300"
                        ]
                    ]
                ],
                [
                    "id": 2,
                    "url": "/someting2",
                    "name": "Mock 2",
                    "description": "Mock Description 2",
                    "image_url": [
                        [
                            "https://picsum.photos/200/300"
                        ]
                    ]
                ],
            ]
        ] as [String : Any]

        let data = Mapper<APIPhotosResponse>().map(JSONObject: mockMap)

        return Observable.just(data)
    }

}
