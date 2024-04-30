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
        if (currentPage + 1) <= lastPage {
            currentPage += 1
        }
        let response = await plantsRepository.tryUpdatePlants(currentPage: currentPage)
        if response.1 != nil {
            lastPage = response.0
            print("tryUpdatePlants()")
            return false
        }
        else {
            lastPage = response.0
            return true
        }
    }
}
