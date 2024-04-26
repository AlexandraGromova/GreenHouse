import Foundation
import Combine

class SearchPlantsRepository {
    
    private let remouteSource: RemouteSource
    var lastPage = 1
    var page = 0
    
    init(remouteSource: RemouteSource) {
        self.remouteSource = remouteSource
    }
    
    func getResponsePlants(watering: String, sunlight: String) async -> Result<ResponsePlants, HttpError> {
        if (page + 1) <= lastPage {
            page += 1
        }
        let response = await self.remouteSource.getSearchResponsePlants(currentPage: page, watering: watering, sunlight: sunlight)
        
        switch response {
        case .success(let value):
            print("success_value1 \(value.last_page)")
            lastPage = value.last_page
            print("success_value2 \(value.last_page)")
        case .failure(_):
            print("error")
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
