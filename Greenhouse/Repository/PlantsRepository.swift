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
    
    func getPlantsfromRS(currentPage: Int) async -> [Plant] {
        let response = await remouteSource.getResponsePlants(currentPage: currentPage)
        switch response {
        case .success(let value):
            return value.data
        case .failure(_):
            return []
        }
    }
     
    func savePlantsInStorage(currentPage: Int) {
        Task {
            let response = await remouteSource.getResponsePlants(currentPage: currentPage)
            switch response {
            case .success(let value):
                try localSource.savePlants(object: value.data)
            case .failure(let error):
                print("testResult error \(error)")
            }
        }
    }
    
    func getPlantsFromStorage() -> AnyPublisher<[PlantLS], any Error> {
        return localSource.getPlants()
    }
}

