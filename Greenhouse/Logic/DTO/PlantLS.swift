import Foundation
import RealmSwift

class PlantLS: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var common_name: String
    @Persisted var image: String
    
    @Persisted var origin: List<String?>
    @Persisted var dimension: String? = ""
    @Persisted var sunlight: List<String?>
    @Persisted var cycle: String? = ""
    @Persisted var watering: String? = ""
    @Persisted var care_level: String? = ""
    @Persisted var medicinal: Bool? = false
    
    convenience init(id: Int, 
                     common_name: String,
                     image: String,
                     origin: List<String?>,
                     dimension: String?,
                     sunlight: List<String?>,
                     cycle: String?,
                     watering: String?,
                     care_level: String?,
                     medicinal: Bool?
    ) {
        self.init()
        self.id = id
        self.common_name = common_name
        self.image = image
        
        self.origin = origin
        self.dimension = dimension
        self.sunlight = sunlight
        self.cycle = cycle
        self.watering = watering
        self.care_level = care_level
        self.medicinal = medicinal
        
    }
}

class DefaultImageLS: Object {
    @Persisted var small_url: String? = nil
    convenience init(small_url: String?) {
        self.init()
        self.small_url = small_url
    }
}


