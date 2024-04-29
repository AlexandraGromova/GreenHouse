import Foundation
import Combine

class SearchPlantsRepository {
    
    private let remouteSource: RemouteSource
    
    init(remouteSource: RemouteSource) {
        self.remouteSource = remouteSource
    }
    
    func getResponsePlants(currentPage: Int, watering: String, sunlight: String) async -> Result<ResponsePlants, HttpError> { let response = await self.remouteSource.getSearchResponsePlants(currentPage: currentPage, watering: watering, sunlight: sunlight)
        
        switch response {
        case .success(let value):
            print("success_value1 \(value.last_page)")
        case .failure(_):
            print("error")
        }
        return response
    }
}
