import Foundation
import RxSwift

final class PhotosListViewModel {
    private let disposeBag = DisposeBag()

    var isLoading = PublishSubject<Bool>()
    var hasNextPage = PublishSubject<Bool>()
    var photos = PublishSubject<[PhotosEntity]?>()

    private let limit = 20

    init() {
        isLoading.onNext(false)
        hasNextPage.onNext(false)
        photos.onNext([])
    }

    func fetch() {
        self.isLoading.onNext(true)

        PhotosAPIService.shared.getPhotos()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] photosData in
                guard let self = self else { return }

                if let element = photosData.element {
                    self.photos.onNext(element)
                }

                self.isLoading.onNext(false)
            }.disposed(by: disposeBag)
    }
}
