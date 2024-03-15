import Foundation
import Combine

class GetSearchPlantsUC {
    
    private let plantsRepository: SearchPlantsRepository
    private let pagination: Pagination
    private let currentPage = 1
    
    init(plantsRepository: SearchPlantsRepository, pagination: Pagination) {
        self.plantsRepository = plantsRepository
        self.pagination = pagination
    }
    
    func execute() async -> AnyPublisher<[UIPlant], Never> {
        return await plantsRepository.getPublisherPlants(currentPage: currentPage, watering: "average", sunlight: "part_shade")
    }
    
}
