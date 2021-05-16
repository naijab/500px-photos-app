import Foundation
import ObjectMapper

class APIPhotosResponse: Mappable {
    var currentPage: Int?
    var totalPages: Int?
    var photos: [PhotosEntity]?

    enum Key {
        static let currentPage = "current_page"
        static let totalPages = "total_pages"
        static let photos = "photos"
    }

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        currentPage <- map[Key.currentPage]
        totalPages  <- map[Key.totalPages]
        photos      <- map[Key.photos]
    }
}


class PhotosEntity: Mappable {
    var id: String?
    var name: String?
    var description: String?
    var imageUrl: [String]?
    var positiveVotesCount: Int?
    var url: String?

    enum Key {
        static let id = "id"
        static let name = "name"
        static let description = "description"
        static let imageUrl = "image_url"
        static let positiveVotesCount = "positive_votes_count"
        static let url = "url"
    }

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id                  <- map[Key.id]
        name                <- map[Key.name]
        description         <- map[Key.description]
        imageUrl            <- map[Key.imageUrl]
        positiveVotesCount  <- map[Key.positiveVotesCount]
        url  <- map[Key.url]
    }
}
