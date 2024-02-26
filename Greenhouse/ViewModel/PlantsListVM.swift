import Foundation
import Combine

class PlantsListVM: ObservableObject {
    
    private let getPlantUC: GetPlantsUC
    private let plantsRepository: PlantsRepository
    private let pagination: Pagination
    @Published var plants: [PlantLS] = []
    @Published var error = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(getPlantUC: GetPlantsUC, plantsRepository: PlantsRepository, pagination: Pagination) {
        self.getPlantUC = getPlantUC
        self.plantsRepository = plantsRepository
        self.pagination = pagination
        tryUpdatePlants(currentPage: loadMoreContent())
        getPlantsfromLS()
        
    }
    
    func getPlantsfromLS() {
        plantsRepository.getPlantsFromStorage()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    
                    print(completion)
                },
                receiveValue: { value in
                    var buferList: [PlantLS] = []
                    self.plants = []
                    buferList = self.plants
                    buferList.append(contentsOf: value)
                    self.plants = buferList
                }
            )
            .store(in: &cancellables)
    }
    
    
    func tryUpdatePlants(currentPage: Int) {
        Task {
            let result = await plantsRepository.tryUpdatePlants(currentPage: currentPage)
            if result != nil {
                error = true
            }
            else {
                error = false
            }
        }
    }
    
    func loadMoreContent() -> Int {
        return pagination.loadMoreContent()
    }
    
    func getError() {
        
    }
    
    
}

