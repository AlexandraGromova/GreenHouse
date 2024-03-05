import Foundation
import RealmSwift
import Combine

class LocalSource {
    
    let realm = try! Realm()
    
    func savePlants(list: [APIPlant]) {
        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    let listPlantLS = list.map { plant in
                        PlantLS(id: plant.id, common_name: plant.common_name, image: plant.default_image?.small_url ?? "")
                    }
                    self.realm.add(listPlantLS, update: .all)
                }
            }
            catch {
                print("errorSavePlants")
            }
        }
    }
    
    
    func getPublisherPlants() -> AnyPublisher<[UIPlant], Never> {
        return realm.objects(PlantLS.self)
            .collectionPublisher
            .map({ result in
                return result.toArray().map { plantLS in
                    UIPlant(id: plantLS.id, name: plantLS.common_name, image: plantLS.image)
                }
            })
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    
    
    
    
    
    
    
    
    
    func savePlantInFav(plant: PlantLS) {
        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    let savePlant = FavoritePlant(id: plant.id, common_name: plant.common_name, image: plant.image )
                    self.realm.add(savePlant, update: .all)
                }
            }
            catch {
                print("errorSavePlants")
            }
        }
    }
    
    func getPublisherFavPlants() -> AnyPublisher<[UIPlant], Never> {
        return realm.objects(FavoritePlant.self)
            .collectionPublisher
            .map({ result in
                return result.toArray().map { dbPlant in
                    UIPlant(id: dbPlant.id, name: dbPlant.common_name, image: dbPlant.image, isFavorite: true)
                }
            })
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    func deleteFavPlant(planID: Int) {
        try! realm.write {
            let objectsToDelete = realm.object(ofType: FavoritePlant.self, forPrimaryKey: planID)
            realm.delete(objectsToDelete!)
        }
    }
    
}

extension Results {
    func toArray() -> [Element] {
        .init(self)
    }
}
