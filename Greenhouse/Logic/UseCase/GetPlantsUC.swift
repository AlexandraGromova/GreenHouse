import Foundation
import Combine

class GetPlantsUC {
    
    private let plantsRepository: PlantsRepository
    var lastPage = 1
    var currentPage = 0
    
    init(plantsRepository: PlantsRepository) {
        self.plantsRepository = plantsRepository
    }
    
    func execute() -> AnyPublisher<[UIPlant], Never> {
        return plantsRepository.getPlantsFromStorage()
    }
    
    func tryUpdatePlants() async -> Bool  {
        let response = await plantsRepository.tryUpdatePlants(currentPage: currentPage)
        if response != nil {
            return false
        }
        else {
            return true
        }
    }
}
