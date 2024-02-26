import Foundation
import RealmSwift

class PlantLS: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var common_name: String
    @Persisted var default_imagels: DefaultImageLS?
    
    convenience init(id: Int, common_name: String, default_imagels: DefaultImageLS?) {
        self.init()
        self.id = id
        self.common_name = common_name
        self.default_imagels = default_imagels
    }
    
}

class DefaultImageLS: Object {
    @Persisted var small_url: String? = nil
    
    convenience init(small_url: String?) {
        self.init()
        self.small_url = small_url
    }
}
