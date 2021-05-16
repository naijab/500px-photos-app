import UIKit

protocol AdsTableViewCellDelegate {
    func didTap(_ cell: AdsTableViewCell)
}

final class AdsTableViewCell: UITableViewCell {

    static let identifier = "AdsTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "AdsTableViewCell", bundle: nil)
    }

    var delegate: AdsTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func didSelect(indexPath: IndexPath) {
        delegate?.didTap(self)
    }
    
}
