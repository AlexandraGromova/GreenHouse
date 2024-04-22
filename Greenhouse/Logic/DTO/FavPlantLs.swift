import Foundation

import RealmSwift

//class FavPlantLS: Object {
//    @Persisted(primaryKey: true) var id: Int
//    @Persisted var common_name: String
//    @Persisted var image: String
//    
//    @Persisted var origins: List<String?>
//    @Persisted var dimension: String? = ""
//    @Persisted var sunlights: List<String?>
//    @Persisted var cycle: String? = ""
//    @Persisted var watering: String? = ""
//    @Persisted var care_level: String? = ""
//    @Persisted var medicinal: Bool? = false
//    
//    convenience init(id: Int,
//                     common_name: String,
//                     image: String,
//                     
//                     origin: String,
//                     dimension: String?,
//                     sunlight: String?,
//                     cycle: String?,
//                     watering: String?,
//                     care_level: String?,
//                     medicinal: Bool?
//    ) {
//        self.init()
//        self.id = id
//        self.common_name = common_name
//        self.image = image
//        
//        self.origins.append(origin)
//        self.dimension = dimension
//        self.sunlights.append(sunlight)
//        self.cycle = cycle
//        self.watering = watering
//        self.care_level = care_level
//        self.medicinal = medicinal
//        
//    }
//}
