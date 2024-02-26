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
            localSource.savePlants(list: value.data)
        case .failure(let error):
            print("testResult error \(error)")
            return error
        }
        return nil
    }
    
    func getError() {
        print("getError")
    }
    
    func getPlantsFromStorage() -> AnyPublisher<[PlantLS], any Error> {
        return localSource.getPlants()
    }
}

