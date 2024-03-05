import RealmSwift
import Foundation

class FavoritePlant: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var common_name: String
    @Persisted var image: String
//    @Persisted var default_imagels: DefaultImageLS?
    
    convenience init(id: Int, common_name: String, image: String) {
        self.init()
        self.id = id
        self.common_name = common_name
        self.image = image
    }
}
