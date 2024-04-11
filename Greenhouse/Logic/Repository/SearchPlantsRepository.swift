import Foundation
import Combine

class SearchPlantsRepository {
    
    private let remouteSource: RemouteSource
    
    init(remouteSource: RemouteSource) {
        self.remouteSource = remouteSource
    }
 
    func getResponsePlants(currentPage: Int, watering: String, sunlight: String) async -> Result<ResponsePlants, HttpError> {
        let response = await self.remouteSource.getSearchResponsePlants(currentPage: currentPage, watering: watering, sunlight: sunlight)
        return response
    }
    
    func getTotalPages() async -> Int {
        let response = await self.remouteSource.getSearchResponsePlants(currentPage: 1, watering: "", sunlight: "")
        switch response {
        case .success(let value):
//           fix print("value \(value.last_page)")
            return value.last_page
        case .failure(_):
            return 0
        }
    }
}
