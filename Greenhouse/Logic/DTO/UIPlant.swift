import Foundation

struct UIPlant: Hashable {
    let id: Int
    let name: String
    var image: String?
    var isFavorite: Bool = false
}

//struct UIDefaultImage: Codable, Hashable {
//    var small_url: String?
//}
