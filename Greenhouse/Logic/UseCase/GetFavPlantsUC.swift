import Foundation
import Combine

class GetFavPlantsUC {
    
    private let repository: FavoriteListRepository
    
    init(repository: FavoriteListRepository) {
        self.repository = repository
    }
    func execute() -> AnyPublisher<[UIPlant], Never> {
        return repository.getPlants()
    }
    
    func savePlant(plant: UIPlant) {
        repository.savePlant(plant: plant)
    }
    
    func deletePlant(plantID: Int) {
        repository.deletePlant(plantID: plantID)
    }
}
