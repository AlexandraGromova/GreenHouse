import Foundation
import RealmSwift
import Combine

class LocalSource {
    
    let realm = try! Realm()
    
    func savePlants(object: [Plant]) throws {
        DispatchQueue.main.async {
            try! self.realm.write {
                print("test_ls_savePlantsInStorage")
                object.forEach { plant in
                    if plant.id == self.realm.object(ofType: PlantLS.self, forPrimaryKey: plant.id)?.id {
                        print("double")
                    }
                    else {
                        let plantLS = PlantLS()
                        plantLS.id = plant.id
                        plantLS.common_name = plant.common_name
                        self.realm.add(plantLS.self)
                        print("add")
                    }
                }
            }
            
        }
    }
    
    func getPlants() -> AnyPublisher<[PlantLS], any Error> {
        print("test_ls_getPlantsFromStorage")
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
