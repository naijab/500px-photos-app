import Foundation

struct PhotosListViewModelState {
    var isLoading = false
    var hasNextPage = false
}

final class PhotosListViewModel {
    let limit = 10
}
