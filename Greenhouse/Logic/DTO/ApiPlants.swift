import Foundation

struct ResponsePlants: Codable {
    var data: [APIPlant]
    var current_page: Int
    var last_page: Int
}

struct APIPlant: Identifiable, Codable, Hashable {
    var id: Int
    var common_name: String
    var default_image: DefaultImage?
}

struct DefaultImage: Codable, Hashable {
    var small_url: String?
}

struct APIDetailPlant: Codable, Hashable {
    var id: Int
    var common_name: String
    var origins: [String]?
    var dimension: String?
    var cycle: String?
    var watering: String?
    var sunlights: [String]?
    var care_level: String?
    var medicinal: Bool?
    var default_image: DefaultImage?
}

