import Foundation
import Combine

class SearchPlantsRepository {
    
    private let remouteSource: RemouteSource
    @Published var lastPage: Int = 1
    
    init(remouteSource: RemouteSource) {
        self.remouteSource = remouteSource
    }
 
    func getResponsePlants(currentPage: Int, watering: String, sunlight: String) async -> Result<ResponsePlants, HttpError> {
        let response = await self.remouteSource.getSearchResponsePlants(currentPage: currentPage, watering: watering, sunlight: sunlight)
        
        switch response {
        case .success(let value):
            print("success_value1 \(value.last_page)")
            lastPage = value.last_page
            print("success_value2 \(value.last_page)")
        case .failure(_):
            lastPage = 1
        }
        
        return response
    }
    
//    func getTotalPages() async -> Int {
//        let response = await self.remouteSource.getSearchResponsePlants(currentPage: 1, watering: "", sunlight: "")
//        switch response {
//        case .success(let value):
//            print("value \(value.last_page)")
//            return value.last_page
//        case .failure(_):
//            return 0
//        }
//    }
}
