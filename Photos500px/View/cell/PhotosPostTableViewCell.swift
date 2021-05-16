import UIKit
import Kingfisher

protocol PhotosPostTableViewCellDelegate {
    func didTap(_ cell: PhotosPostTableViewCell, photos: PhotosEntity)
}

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

    private var photos: PhotosEntity?

    var delegate: PhotosPostTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        photosImageView.layer.masksToBounds = true
        photosImageView.layer.cornerRadius = self.photosImageView.frame.width / 12
    }


    func bindData(with data: PhotosPostTableViewCellData) {
        if let photos = data.photos {
            self.photos = photos
            titleLabel?.text = photos.name ?? ""
            descriptionLabel?.text = photos.description ?? ""
            voteLabel?.text = (photos.positiveVotesCount ?? 0).formatToCurrencyWithoutSimbol
            photosImageView?.kf.setImage(with: URL(string: photos.imageUrl?.first ?? ""))
        }
    }

    func didSelect(indexPath: IndexPath) {
        if let photos = self.photos {
            delegate?.didTap(self, photos: photos)
        }
    }
    
}
