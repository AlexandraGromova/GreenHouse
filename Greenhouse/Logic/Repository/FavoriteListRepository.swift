import Foundation
import Combine

class FavoriteListRepository {
    private let localSourse: LocalSource
    private let remouteSource: RemouteSource
    
    init(localSourse: LocalSource, remouteSource: RemouteSource) {
        self.localSourse = localSourse
        self.remouteSource = remouteSource
    }
    
    func savePlant(plant: UIPlant) {
        localSourse.savePlantInFav(plant: plant)
    }
    
    func getPlants() -> AnyPublisher<[UIPlant], Never> {
        return localSourse.getPublisherFavPlants()
    }
    
    func deletePlant(plantID: Int) {
        localSourse.deleteFavPlant(planID: plantID)
    }
}
