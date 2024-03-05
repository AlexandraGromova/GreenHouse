import Foundation

struct ResponsePlants: Codable {
    var data: [APIPlant]
    var current_page: Int
    var last_page: Int
    var total: Int
}

struct APIPlant: Identifiable, Codable, Hashable {
    var id: Int
    var common_name: String
    var default_image: DefaultImage?
}

struct DefaultImage: Codable, Hashable {
    var small_url: String?
}

