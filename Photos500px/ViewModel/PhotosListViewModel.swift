import Foundation
import RxSwift

final class PhotosListViewModel {
    private let disposeBag = DisposeBag()

    var isLoadMoreCompleted = PublishSubject<Bool>()
    var isLoading = PublishSubject<Bool>()
    var hasNextPage = PublishSubject<Bool>()
    var photos = PublishSubject<[PhotosEntity]?>()

    private var lastestPhotos: [PhotosEntity] = []
    private var currentPage = 1

    init() {
        isLoading.onNext(false)
        isLoadMoreCompleted.onNext(true)
        hasNextPage.onNext(false)
        photos.onNext([])
    }

    func fetch() {
        self.isLoading.onNext(true)

        PhotosAPIService.shared.getPhotos()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] data in
                guard let self = self else { return }

                if let element = data.element {
                    self.lastestPhotos = element?.photos ?? []
                    self.photos.onNext(element?.photos)

                    self.hasNextPage.onNext(self.currentPage < element?.totalPages ?? 1)
                }

                self.isLoading.onNext(false)
            }.disposed(by: disposeBag)
    }

    func loadMore() {
        self.isLoading.onNext(true)
        self.isLoadMoreCompleted.onNext(false)
        self.currentPage += 1

        print("Load more on : \( self.currentPage)")

        PhotosAPIService.shared.getPhotos(page: currentPage)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] data in
                guard let self = self else { return }

                if let element = data.element {
                    self.hasNextPage.onNext(self.currentPage < element?.totalPages ?? 1)

                    var newPhotos = self.lastestPhotos
                    newPhotos.append(contentsOf: element?.photos ?? [])

                    self.photos.onNext(newPhotos)
                    self.isLoadMoreCompleted.onNext(true)
                }

                self.isLoading.onNext(false)
            }
            .disposed(by: disposeBag)
    }
}
