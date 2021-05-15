import UIKit

class AdsTableViewCell: UITableViewCell {

    static let identifier = "AdsTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "AdsTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
