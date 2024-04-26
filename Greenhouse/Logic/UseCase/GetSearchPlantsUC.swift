import Foundation
import Combine

class GetSearchPlantsUC {
    
    private let plantsRepository: SearchPlantsRepository
    
    init(plantsRepository: SearchPlantsRepository) {
        self.plantsRepository = plantsRepository
    }
    
    func execute(watering: String, sunlight: String) async -> Result<[UIPlant], HttpError> {
        //fix lastpage
//        pagination.getSearchTotalPages()
        let result = await plantsRepository.getResponsePlants( watering: watering, sunlight: sunlight).flatMap { responsePlants in
                .success(responsePlants.data.map { plant in
                    UIPlant(id: plant.id, name: plant.common_name, image: plant.default_image?.small_url, isFavorite: false)
                })
        }
        
        return result
    }
    
//    func updateValuePage() {
//        print("test_updateValuePage()1 \(pagination.lastPage)")
//        pagination.updateValuePage()
//        pagination.getSearchTotalPages()
//        print("test_updateValuePage()2 \(pagination.lastPage)")
//    }
}

