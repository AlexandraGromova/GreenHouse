import Foundation
import Combine

class FavoriteListRepository {
    private let localSourse: LocalSource
    
    init(localSourse: LocalSource) {
        self.localSourse = localSourse
    }
    
    func savePlant(plant: PlantLS) {
        localSourse.savePlantInFav(plant: plant)
    }
    
    func getPlants() -> AnyPublisher<[UIPlant], Never> {
        return localSourse.getPublisherFavPlants()
    }
    
    func deletePlant(plantID: Int) {
        localSourse.deleteFavPlant(planID: plantID)
    }
}
