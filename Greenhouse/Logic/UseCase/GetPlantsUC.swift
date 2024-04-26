import Foundation
import Combine

class GetPlantsUC {
    
    private let plantsRepository: PlantsRepository
    
    init(plantsRepository: PlantsRepository) {
        self.plantsRepository = plantsRepository
    }
    
    func execute() -> AnyPublisher<[UIPlant], Never> {
        return plantsRepository.getPlantsFromStorage()
    }
    
    func tryUpdatePlants() async -> Bool  {
        //pagination
        let error = await plantsRepository.tryUpdatePlants()//pagination.getNewValuesPage()//)
        if error != nil {
            return false
        }
        else {
            return true
        }
    }
}
