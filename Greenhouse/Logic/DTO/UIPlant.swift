import Foundation

struct UIPlant: Hashable {
    let id: Int
    let name: String
    var image: String?
    var isFavorite: Bool = false
    
    var origins: [String]?
    var dimension: String?
    var sunlights: [String]?
    var cycle: String?
    var watering: String?
    var care_level: String?
    var medicinal: Bool?
}

