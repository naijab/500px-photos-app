import UIKit
import Kingfisher

struct PhotosPostTableViewCellData {
    let title: String
    let description: String
    let photos: String
    let voteCount: Int
}

final class PhotosPostTableViewCell: UITableViewCell {

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
        titleLabel.font.withSize(16)
        titleLabel.textColor = UIColor(named: AppColor.title.rawValue)

        descriptionLabel.font.withSize(12)
        descriptionLabel.textColor = UIColor(named: AppColor.description.rawValue)

        voteLabel.font.withSize(10)
        voteLabel.textColor = UIColor(named: AppColor.voteCount.rawValue)
    }

    private func bindData(with data: PhotosPostTableViewCellData) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        voteLabel.text = data.voteCount.formatToCurrencyWithoutSimbol
        photosImageView.kf.setImage(with: URL(string: data.photos))
    }
    
}
