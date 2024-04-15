import Foundation

struct UIPlant: Hashable {
    let id: Int
    let name: String
    var image: String?
    var isFavorite: Bool = false
    
    var origin: [String]?
    var dimension: String?
    var sunlight: [String]?
    var cycle: String?
    var watering: String?
    var care_level: String?
    var medicinal: Bool?
}

