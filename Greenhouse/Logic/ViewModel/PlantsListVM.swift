import Foundation
import Combine

class PlantsListVM: ObservableObject {
    
    @Published var plants: [UIPlant] = []
    @Published var hasError = true
    @Published var isSearchMode = false
    @Published var searchParams : SearchParameters = SearchParameters(watering: "", sunlight: "")
    
    @Published private var remotePlants: [UIPlant] = []
    
    private let favoriteRepository: FavoriteListRepository //todo delete
    private let getPlantsUC: GetPlantsUC
    private let getSearchPlantsUC: GetSearchPlantsUC
    private let pagination: Pagination
    
    private var cancellables = Set<AnyCancellable>()
    
    init(getPlantsUC: GetPlantsUC, getSearchPlantsUC: GetSearchPlantsUC, pagination: Pagination, favoriteRepository: FavoriteListRepository) {
        self.getPlantsUC = getPlantsUC
        self.getSearchPlantsUC = getSearchPlantsUC
        self.favoriteRepository = favoriteRepository
        self.pagination = pagination
        $isSearchMode
            .receive(on: DispatchQueue.main)
            .sink { value in
                if value == true {
                    self.plants = []
                    getSearchPlantsUC.updateValuePage()
                    self.getSearchPlants(watering: self.searchParams.watering, sunlight: self.searchParams.sunlight)
                }
            }
            .store(in: &cancellables)
        tryUpdatePlants()
        getPlants()
        $remotePlants
            .receive(on: DispatchQueue.main)
            .sink { value in
            }
            .store(in: &cancellables)
        favoriteRepository.getPlants()
            .receive(on: DispatchQueue.main)
            .sink { value in
            }
            .store(in: &cancellables)
        getRemotePlants()
    }
    
    private func getRemotePlants() {
        return $remotePlants
            .combineLatest(favoriteRepository.getPlants()) { plants, favPlants in
                var result: [UIPlant] = []
                for item in plants {
                    var plant = item
                    if favPlants.contains(where: {$0.id == item.id}) {
                        plant.isFavorite = true
                    }
                    result.append(plant)
                }
                return result
            }
            .assign(to: &$plants)
        
    }
    
    func savePlant(plant: UIPlant) {
        favoriteRepository.savePlant(plant: PlantLS(id: plant.id, common_name: plant.name, image: plant.image ?? ""))
    }
    
    func deletePlant(plantID: Int) {
        favoriteRepository.deletePlant(plantID: plantID)
    }
    
    func getSearchPlants(watering: String, sunlight: String) {
        Task {
            let result = await getSearchPlantsUC.execute(watering: watering, sunlight: sunlight)
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    var buferList: [UIPlant] = []
                    buferList = self.remotePlants
                    buferList.append(contentsOf: value)
                    self.remotePlants = buferList
                }
            case .failure(let error):
                print("testResult error \(error)")
            }
        }
    }
    
    func getPlants() {
        getPlantsUC.execute()
            .receive(on: DispatchQueue.main)
            .sink { value in
                if !self.isSearchMode {
                    var buferList: [UIPlant] = []
                    self.plants = []
                    buferList = value
                    self.plants = buferList
                }
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

