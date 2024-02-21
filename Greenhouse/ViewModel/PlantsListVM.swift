import Foundation
import Combine

class PlantsListVM: ObservableObject {
    
    private let getPlantUC: GetPlantsUC
    private let plantsRepository: PlantsRepository
    private let pagination: Pagination
    @Published var plants: [PlantLS] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(getPlantUC: GetPlantsUC, plantsRepository: PlantsRepository, pagination: Pagination) {
        self.getPlantUC = getPlantUC
        self.plantsRepository = plantsRepository
        self.pagination = pagination
        savePlantsInStorage(currentPage: loadMoreContent())
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
                    buferList = self.plants
                    buferList.append(contentsOf: value)
                    self.plants = buferList
                }
            )
            .store(in: &cancellables)
    }
    
    
    func savePlantsInStorage(currentPage: Int) {
        plantsRepository.savePlantsInStorage(currentPage: currentPage)
        print("testVM_savePlantsInStorage")
    }
    
    func loadMoreContent() -> Int {
        return pagination.loadMoreContent()
    }
    
    
}

