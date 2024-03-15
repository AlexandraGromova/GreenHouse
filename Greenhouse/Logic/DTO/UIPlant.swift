import Foundation

struct UIPlant: Hashable {
    let id: Int
    let name: String
    var image: String?
    var isFavorite: Bool = false
}
