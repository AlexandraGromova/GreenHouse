import Foundation
import RealmSwift

class PlantLS: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var common_name: String
    @Persisted var image: String
    
    convenience init(id: Int, common_name: String, image: String) {
        self.init()
        self.id = id
        self.common_name = common_name
        self.image = image
    }
    
}

class DefaultImageLS: Object {
    @Persisted var small_url: String? = nil
    convenience init(small_url: String?) {
        self.init()
        self.small_url = small_url
    }
}


