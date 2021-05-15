import Foundation

enum AppColor: String {
    case title
    case description
    case voteCount

    var rawValue: String {
         switch self {
         case .title: return "titleColor"
         case .description: return "descriptionColor"
         case .voteCount: return "voteCount"
         }
     }
}
