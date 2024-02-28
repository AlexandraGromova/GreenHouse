import Foundation
import RealmSwift
import Combine

class LocalSource {
    
    let realm = try! Realm()
    
    func savePlants(list: [Plant]) {
        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    let listPlantLS = list.map { plant in
                        PlantLS(id: plant.id, common_name: plant.common_name, default_imagels: DefaultImageLS(small_url: plant.default_image?.small_url))
                    }
                    self.realm.add(listPlantLS, update: .all)
                }
            }
            catch {
                print("errorSavePlants")
            }
        }
    }
    
    func getPlants() -> AnyPublisher<[PlantLS], any Error> {
        return realm.objects(PlantLS.self)
            .collectionPublisher
            .map({ result in
                return result.toArray()
            })
            .eraseToAnyPublisher()
    }
    
}

extension Results {
    func toArray() -> [Element] {
        .init(self)
    }
}
