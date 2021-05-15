import Foundation

extension Int {

    var formatToCurrencyWithoutSimbol: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .none
        currencyFormatter.locale = Locale.current
        let result = currencyFormatter.string(from: NSNumber(value: self))!
        return result
    }

}
