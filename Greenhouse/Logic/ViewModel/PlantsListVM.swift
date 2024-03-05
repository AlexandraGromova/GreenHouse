import Foundation
import Combine

class PlantsListVM: ObservableObject {
    
    private let favoriteRepository: FavoriteListRepository
    private let getPlantsUC: GetPlantsUC
    private let pagination: Pagination
    @Published var plants: [UIPlant] = []
    @Published var hasError = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init(getPlantsUC: GetPlantsUC, pagination: Pagination, favoriteRepository: FavoriteListRepository) {
        self.getPlantsUC = getPlantsUC
        self.favoriteRepository = favoriteRepository
        self.pagination = pagination
        tryUpdatePlants()
        getPlants()
    }
    
    func savePlant(plant: UIPlant) {
        favoriteRepository.savePlant(plant: PlantLS(id: plant.id, common_name: plant.name, image: plant.image ?? ""))
    }
    
    func deletePlant(plantID: Int) {
        favoriteRepository.deletePlant(plantID: plantID)
    }
    
    func getPlants() {
        getPlantsUC.execute()
            .receive(on: DispatchQueue.main)
            .sink { value in
                var buferList: [UIPlant] = []
                self.plants = []
                buferList = self.plants
                buferList.append(contentsOf: value)
                self.plants = buferList
            }
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

