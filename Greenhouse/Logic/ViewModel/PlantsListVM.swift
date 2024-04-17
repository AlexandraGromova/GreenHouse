import Foundation
import Combine

class PlantsListVM: ObservableObject {
    
    @Published var plants: [UIPlant] = []
    @Published var plantDetails: UIPlant?
    @Published var hasError = true
    @Published var isSearchMode = false
    @Published var searchParams : SearchParameters = SearchParameters(watering: "", sunlight: "")
    
    @Published private var searchPlants: [UIPlant] = []
    
    private let getFavPlantsUC: GetFavPlantsUC
    private let getPlantsUC: GetPlantsUC
    private let getSearchPlantsUC: GetSearchPlantsUC
    private let getPlantDetailsUC: GetPlantDetailsUC
    private let pagination: Pagination
    
    private var cancellables = Set<AnyCancellable>()
    
    init(getPlantsUC: GetPlantsUC, getSearchPlantsUC: GetSearchPlantsUC, pagination: Pagination, getFavPlantsUC: GetFavPlantsUC, getPlantDetailsUC: GetPlantDetailsUC) {
        self.getPlantsUC = getPlantsUC
        self.getSearchPlantsUC = getSearchPlantsUC
        self.getFavPlantsUC = getFavPlantsUC
        self.getPlantDetailsUC = getPlantDetailsUC
        self.pagination = pagination
        
        $searchParams
            .receive(on: DispatchQueue.main)
            .sink { value in
                self.searchPlants = []
            }
            .store(in: &cancellables)
        
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
        getRemotePlants()
    }
    
    // ------ fav plants ----- //
    func savePlant(plant: UIPlant) {
        getFavPlantsUC.savePlant(plant: PlantLS(id: plant.id, common_name: plant.name, image: plant.image ?? ""))
    }
    
    func deletePlant(plantID: Int) {
        getFavPlantsUC.deletePlant(plantID: plantID)
    }
    // ----- search plants ------ //
    func getSearchPlants(watering: String, sunlight: String) {
        Task {
            let result = await getSearchPlantsUC.execute(watering: watering, sunlight: sunlight)
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    var buferList: [UIPlant] = []
                    buferList = self.searchPlants
                    buferList.append(contentsOf: value)
                    self.searchPlants = buferList
                }
            case .failure(let error):
                print("testResult error \(error)")
            }
        }
    }
    
    private func getRemotePlants() {
        $searchPlants
            .combineLatest(getFavPlantsUC.execute()) { plants, favPlants in
                var result: [UIPlant] = []
                for item in plants {
                    var plant = item
                    if favPlants.contains(where: {$0.id == item.id}) {
                        plant.isFavorite = true
                    }
                    result.append(plant)
                }
                print("test_search_u plants \(plants.map{$0.id}) favorits \(favPlants.map{$0.id})")
                return result
            }
            .assign(to: &$plants)
        
    }
    // ------ all plants ------ //
    private func getPlants() {
        getPlantsUC.execute()
            .receive(on: DispatchQueue.main)
            .sink { value in
                if !self.isSearchMode {
                    self.plants = value
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
    
    // ------ plant details ------ //
    func getPlantDetails(id: Int) {
        Task {
            let result = await self.getPlantDetailsUC.execute(id: id)
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.plantDetails = value
                }
            case .failure(let error):
                print("testResult error \(error)")
            }
        }
    }
}

