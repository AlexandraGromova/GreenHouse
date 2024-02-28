import Foundation
import Combine

class PlantsListVM: ObservableObject {
    
    private let getPlantsUC: GetPlantsUC
    private let pagination: Pagination
    @Published var plants: [PlantLS] = []
    @Published var hasError = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init(getPlantsUC: GetPlantsUC, pagination: Pagination) {
        self.getPlantsUC = getPlantsUC
        self.pagination = pagination
        tryUpdatePlants()
        getPlants()
    }
    
    func getPlants() {
        getPlantsUC.execute()
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
    
    func tryUpdatePlants() {
        Task {
            let bufferValue = await getPlantsUC.tryUpdatePlants()
            DispatchQueue.main.async {
                self.hasError = bufferValue
            }
        }
    }
}

