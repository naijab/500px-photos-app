import UIKit

final class PhotosListViewController: UIViewController {

    @IBOutlet private weak var photosListTableView: UITableView!

    var viewModel: PhotosListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = PhotosListViewModel()
        setupPhotosListTableView()
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
        return viewModel.state.photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let row = indexPath.row


        let cell = tableView.dequeueReusableCell(
            withIdentifier: PhotosPostTableViewCell.identifier,
            for: indexPath
        ) as! PhotosPostTableViewCell

        cell.bindData(
            with: PhotosPostTableViewCellData(
                title: "Lorem ipsum dolor sit amet, consectetur",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                photos: "https://picsum.photos/200/300",
                voteCount: 1234
            )
        )

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
        print("Pull refesh !")

        // TODO: Handle call fetch and reload table

        DispatchQueue.main.async {
            self.photosListTableView.refreshControl?.endRefreshing()
        }
    }

}
