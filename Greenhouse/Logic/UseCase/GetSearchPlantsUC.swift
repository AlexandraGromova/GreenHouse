import Foundation
import Combine

class GetSearchPlantsUC {
    
    private let plantsRepository: SearchPlantsRepository
    private let pagination: Pagination
    
    init(plantsRepository: SearchPlantsRepository, pagination: Pagination) {
        self.plantsRepository = plantsRepository
        self.pagination = pagination
    }
    
    func execute(watering: String, sunlight: String) async -> Result<[UIPlant], HttpError> {
        print("test_page \(pagination.page)")
        let result = await plantsRepository.getResponsePlants(currentPage: pagination.getNewValuesSearchPage(), watering: watering, sunlight: sunlight).flatMap { responsePlants in
                .success(responsePlants.data.map { plant in
                    UIPlant(id: plant.id, name: plant.common_name, image: plant.default_image?.small_url, isFavorite: false)
                })
        }
        return result
    }
}
