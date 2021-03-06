import Foundation
import RxSwift

final class PhotosListViewModel {
    private var photosService: IPhotosAPIService
    private let disposeBag = DisposeBag()
    private var lastestPhotos: [PhotosEntity] = []
    private var currentPage = 1

    var isLoadMoreCompleted = PublishSubject<Bool>()
    var isLoading = PublishSubject<Bool>()
    var hasNextPage = PublishSubject<Bool>()
    var photos = PublishSubject<[PhotosEntity]>()

    init(photosService: IPhotosAPIService) {
        self.photosService = photosService
        initState()
    }

    private func initState() {
        isLoading.onNext(false)
        isLoadMoreCompleted.onNext(true)
        hasNextPage.onNext(false)
        photos.onNext([])
    }

    func fetch() {
        self.isLoading.onNext(true)

        self.photosService.getPhotos(page: 1)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] data in
                guard let self = self else { return }

                if let element = data.element {
                    self.lastestPhotos = element?.photos ?? []
                    self.photos.onNext(element?.photos ?? [])
                    self.hasNextPage.onNext(self.currentPage < element?.totalPages ?? 1)
                }

                self.isLoading.onNext(false)
            }.disposed(by: disposeBag)
    }

    func loadMore() {
        self.isLoading.onNext(true)
        self.isLoadMoreCompleted.onNext(false)
        self.currentPage += 1

        self.photosService.getPhotos(page: currentPage)
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
