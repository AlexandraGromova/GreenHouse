import Foundation
import Combine

class GetSearchPlantsUC {
    
    private let plantsRepository: SearchPlantsRepository
    private var lastPage = 1
    private var currentPage = 0
    
    init(plantsRepository: SearchPlantsRepository) {
        self.plantsRepository = plantsRepository
    }
    
    func execute(watering: String, sunlight: String) async -> Result<[UIPlant], HttpError> {
        if (currentPage + 1) <= lastPage {
            currentPage += 1
        }
        let responseResult = await plantsRepository.getResponsePlants(currentPage: currentPage, watering: watering, sunlight: sunlight)
        
        switch responseResult {
        case .success(let response):
            
            lastPage = response.last_page
            
            let plants = response.data.map { plant in
                UIPlant(id: plant.id, name: plant.common_name, image: plant.default_image?.small_url, isFavorite: false)
            }
            return .success(plants)
        case .failure(let error):
            return .failure(error)
            
        }
    }
}

