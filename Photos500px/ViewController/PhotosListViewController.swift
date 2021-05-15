import UIKit
import RxSwift

final class PhotosListViewController: UIViewController {

    @IBOutlet private weak var photosListTableView: UITableView!

    private let disposeBag = DisposeBag()

    var viewModel: PhotosListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = PhotosListViewModel()
        setupPhotosListTableView()
        setupBinding()

        viewModel.fetch()
    }

    private func setupPhotosListTableView() {
        photosListTableView.register(
            PhotosPostTableViewCell.nib(),
            forCellReuseIdentifier: PhotosPostTableViewCell.identifier
        )
        photosListTableView.register(
            AdsTableViewCell.nib(),
            forCellReuseIdentifier: AdsTableViewCell.identifier
        )
        photosListTableView.delegate = self
        photosListTableView.dataSource = self

        photosListTableView.refreshControl = UIRefreshControl()
        photosListTableView.refreshControl?.addTarget(
            self, action: #selector(didPullRefresh),
            for: .valueChanged
        )
    }

    private var isLoading: Bool = false
    private var hasNextPage: Bool = false
    private var photos: [PhotosEntity]? = []

    private func setupBinding() {
        viewModel.isLoading.subscribe {
            self.isLoading = $0
        }.disposed(by: disposeBag)

        viewModel.hasNextPage.subscribe {
            self.isLoading = $0
        }.disposed(by: disposeBag)

        viewModel.photos.subscribe {
            if let element = $0.element {

                self.photos = element

                print("self.photos - \(self.photos)")
            }
            self.photosListTableView.reloadData()
        }.disposed(by: disposeBag)
    }

}

extension PhotosListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row

        // TODO: Implement load more
        //  if row == viewModel.photosList.count - 1,
        //     viewModel.hasNextPage {
        //     print("Load more !!")
        //  }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension PhotosListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row

        let cell = tableView.dequeueReusableCell(
            withIdentifier: PhotosPostTableViewCell.identifier,
            for: indexPath
        ) as! PhotosPostTableViewCell

        if let photos = self.photos, !photos.isEmpty {
            let item = photos[row]

            cell.bindData(
                with: PhotosPostTableViewCellData(
                    title: item.name ?? "",
                    description: item.description ?? "",
                    photos: item.imageUrl?.first ?? "",
                    voteCount: item.positiveVotesCount ?? 0
                )
            )
        }

        // FIX: Ads will show every 5th item between photos post
        print("Row Mod: \(row) ==> \(row % 4)")

        if row > 0, row % 5 == 0 {

            let cell = tableView.dequeueReusableCell(
                withIdentifier: AdsTableViewCell.identifier,
                for: indexPath
            ) as! AdsTableViewCell

            return cell
        }

        return cell
    }

}

extension PhotosListViewController {

    @objc private func didPullRefresh() {
        viewModel.fetch()
        DispatchQueue.main.async {
            self.photosListTableView.refreshControl?.endRefreshing()
        }
    }

}
