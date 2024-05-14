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
                        PlantLS(id: plant.id,
                                common_name: plant.common_name,
                                image: plant.default_image?.small_url ?? "")
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
                    UIPlant(id: plantLS.id, name: plantLS.common_name, image: plantLS.image, origins: [])
                }
            })
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    //----------Favorites----------//
    
    
    func savePlantInFav(plant: UIPlant) {
        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    let savePlant = FavoritePlant(id: plant.id,
                                                  common_name: plant.name,
                                                  image: plant.image ?? "",
                                                  origin: plant.origins.first ?? "",
                                                  dimension: plant.dimension,
                                                  sunlight: plant.sunlights?.first,
                                                  cycle: plant.cycle,
                                                  watering: plant.watering,
                                                  care_level: plant.care_level,
                                                  medicinal: plant.medicinal
                    )
                    print("save_plant_origins \(plant.origins.first ?? "")")
                    self.realm.add(savePlant, update: .all)
                }
            }
            catch {
                print("errorSavePlants")
            }
        }
    }
    
    func getPlantDetails(id: Int) -> FavoritePlant? {
        guard let object = realm.object(ofType: FavoritePlant.self, forPrimaryKey: id) else {
            return nil
        }
        return object
    }
    
    func getPublisherFavPlants() -> AnyPublisher<[UIPlant], Never> {
        return realm.objects(FavoritePlant.self)
            .collectionPublisher
            .map({ result in
                print("test_dbPlant \(String(describing: result.toArray().first?.origins.first))")
                return result.toArray().map { dbPlant in
                    UIPlant(id: dbPlant.id,
                            name: dbPlant.common_name,
                            image: dbPlant.image,
                            isFavorite: true,
                            origins: ["\(dbPlant.origins.first ?? "")"],
                            dimension: dbPlant.dimension,
                            sunlights: ["\(String(describing: dbPlant.sunlights.first))"],
                            cycle: dbPlant.cycle,
                            watering: dbPlant.watering,
                            care_level: dbPlant.care_level,
                            medicinal: dbPlant.medicinal
                    )
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
