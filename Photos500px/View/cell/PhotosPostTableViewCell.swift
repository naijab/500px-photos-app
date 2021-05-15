import UIKit
import Kingfisher
import SkeletonView

struct PhotosPostTableViewCellData {
    var photos: PhotosEntity? = nil

    init(photos: PhotosEntity? = nil) {
        self.photos = photos
    }
}

final class PhotosPostTableViewCell: UITableViewCell {

    static let identifier = "PhotosPostTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "PhotosPostTableViewCell", bundle: nil)
    }

    @IBOutlet private weak var photosImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var voteImageView: UIImageView!
    @IBOutlet private weak var voteLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        titleLabel.isSkeletonable = true
        descriptionLabel.isSkeletonable = true
        voteLabel.isSkeletonable = true

        photosImageView.isSkeletonable = true
        photosImageView.layer.masksToBounds = true
        photosImageView.layer.cornerRadius = self.photosImageView.frame.width / 12
    }

    func bindData(with data: PhotosPostTableViewCellData) {
        if let photos = data.photos {
            titleLabel?.text = photos.name ?? ""
            descriptionLabel?.text = photos.description ?? ""
            voteLabel?.text = (photos.positiveVotesCount ?? 0).formatToCurrencyWithoutSimbol
            photosImageView?.kf.setImage(with: URL(string: photos.imageUrl?.first ?? ""))
        }
    }
    
}
