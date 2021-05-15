import UIKit
import Kingfisher

struct PhotosPostTableViewCellData {
    let title: String
    let description: String
    let photos: String
    let voteCount: Int
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
        photosImageView.layer.masksToBounds = true
        photosImageView.layer.cornerRadius = self.photosImageView.frame.width / 12
    }

    func bindData(with data: PhotosPostTableViewCellData) {
        titleLabel?.text = data.title
        descriptionLabel?.text = data.description
        voteLabel?.text = data.voteCount.formatToCurrencyWithoutSimbol
        photosImageView?.kf.setImage(with: URL(string: data.photos))
    }
    
}
