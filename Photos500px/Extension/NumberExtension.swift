import Foundation

extension Int {

    var formatToCurrencyWithoutSimbol: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }

}
