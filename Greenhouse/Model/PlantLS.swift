import Foundation
import RealmSwift

class PlantLS: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var common_name: String
}
