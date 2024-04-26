import Foundation
import RealmSwift
import Combine

class PlantsRepository {
    
    private let remouteSource: RemouteSource
    private let localSource: LocalSource
    
    var lastPage = 1
    var page = 0
    
    init(remouteSource: RemouteSource, localSource: LocalSource) {
        self.remouteSource = remouteSource
        self.localSource = localSource
    }
    
    func tryUpdatePlants() async -> HttpError? {
        if (page + 1) <= lastPage {
            page += 1
            let response = await self.remouteSource.getResponsePlants(currentPage: page)
            switch response {
            case .success(let value):
                self.localSource.savePlants(list: value.data)
                self.lastPage = value.last_page
            case .failure(let error):
                return error
            }
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
    
    
//    func getTotalPages() async -> Int {
//        let response = await self.remouteSource.getResponsePlants(currentPage: 1)
//        switch response {
//        case .success(let value):
//            return value.last_page
//        case .failure(_):
//            return 0
//        }
//    }
    
}

