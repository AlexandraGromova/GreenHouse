import Foundation
import Combine

class SearchPlantsRepository {
    
    private let remouteSource: RemouteSource
    
    init(remouteSource: RemouteSource) {
        self.remouteSource = remouteSource
    }
 
    func getResponsePlants(currentPage: Int, watering: String, sunlight: String) async -> [APIPlant] {
        let response = await self.remouteSource.getSearchResponsePlants(currentPage: currentPage, watering: watering, sunlight: sunlight)
        switch response {
        case .success(let value):
            print("testResult value \(value.data)")
            return value.data
        case .failure(let error):
            print("testResult error \(error)")
            return []
        }
    }
    
    func getPublisherPlants(currentPage: Int, watering: String, sunlight: String) async -> AnyPublisher<[UIPlant], Never> {
        let response = await getResponsePlants(currentPage: currentPage, watering: watering, sunlight: sunlight)
        return response
            .publisher
            .map { plant in
                UIPlant(id: plant.id, name: plant.common_name, image: plant.default_image?.small_url, isFavorite: false)
            }
            .collect()
            .eraseToAnyPublisher()
    }
}
