import Foundation
import RealmSwift
import Combine

class PlantsRepository {
    
    private let remouteSource: RemouteSource
    private let localSource: LocalSource
    
    init(remouteSource: RemouteSource, localSource: LocalSource) {
        self.remouteSource = remouteSource
        self.localSource = localSource
    }
    
    func tryUpdatePlants(currentPage: Int) async -> HttpError? {
        let response = await self.remouteSource.getResponsePlants(currentPage: currentPage)
        switch response {
        case .success(let value):
            self.localSource.savePlants(list: value.data)
        case .failure(let error):
            print("testResult error \(error)")
            return error
        }
        return nil
    }
    
    func getPlantsFromStorage() -> AnyPublisher<[UIPlant], Never> {
        return localSource.getPublisherPlants()
            .combineLatest(localSource.getPublisherFavPlants()) { plants, favPlants in
                var result: [UIPlant] = []
                for item in plants {
                    var plant = item
                    if favPlants.contains(where: {$0.id == item.id}) {
                        plant.isFavorite = true
                    }
                    result.append(plant)
                }
                return result
            }
            .eraseToAnyPublisher()
    }
    
    
    func getTotalPages() async -> Int {
        let response = await self.remouteSource.getResponsePlants(currentPage: 1)
        switch response {
        case .success(let value):
            return value.total
        case .failure(_):
            return 0
        }
    }
    
}

