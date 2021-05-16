import UIKit
import RxSwift
import SVProgressHUD

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
            if let isLoading = $0.element {
                self.isLoading = isLoading

                if isLoading {
                    DispatchQueue.main.async {
                        SVProgressHUD.show()
                    }
                } else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                    }
                }
            }

        }.disposed(by: disposeBag)


        viewModel.isLoadMoreCompleted.subscribe {
            if let isLoadMoreCompleted = $0.element {
                DispatchQueue.main.async {
                    self.photosListTableView.tableFooterView?.isHidden = isLoadMoreCompleted
                }
            }
        }.disposed(by: disposeBag)

        viewModel.hasNextPage.subscribe {
            self.hasNextPage = $0
        }.disposed(by: disposeBag)

        viewModel.photos.subscribe {
            if let photos = $0.element {
                self.photos = photos

                DispatchQueue.main.async {
                    self.photosListTableView.reloadData()
                }
            }
        }.disposed(by: disposeBag)
    }

    private var spinner: UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: 100
        )
        return spinner
    }

}

extension PhotosListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1

        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex,
           self.hasNextPage {

            self.photosListTableView.tableFooterView = spinner
            self.photosListTableView.tableFooterView?.isHidden = false

            self.viewModel.loadMore()
        }
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

        if row % 5 != 0, row >= 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PhotosPostTableViewCell.identifier,
                for: indexPath
            ) as! PhotosPostTableViewCell

            if let photos = self.photos, !photos.isEmpty {
                let item = photos[row]
                cell.bindData(
                    with: PhotosPostTableViewCellData(
                        photos: item
                    )
                )
            }

            return cell
        } else if (row > 0) {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AdsTableViewCell.identifier,
                for: indexPath
            ) as! AdsTableViewCell

            return cell
        }

        return UITableViewCell()
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
