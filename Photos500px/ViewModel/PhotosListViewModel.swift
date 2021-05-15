import Foundation

struct PhotosListViewModelState {
    var isLoading = false
    var hasNextPage = false
    var photos: [String] = []
}

final class PhotosListViewModel {
    var state: PhotosListViewModelState
    let limit = 20

    init () {
        state = PhotosListViewModelState()

        state.photos = [
            "lorem 1",
            "lorem 2",
            "lorem 3",
            "lorem 4",
            "lorem 5",
            "lorem 6",
            "lorem 7",
            "lorem 8",
            "lorem 9",
            "lorem 10",
            "lorem 11",
            "lorem 12",
            "lorem 13",
            "lorem 14",
            "lorem 15",
            "lorem 16",
            "lorem 17",
            "lorem 18",
            "lorem 19",
            "lorem 20",
        ]
    }
}
