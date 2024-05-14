import Foundation
import Combine

class PlantDetailsVM: ObservableObject {
    
    @Published var plantDetails = UIPlant(id: 0, name: "", origins: [])
    
    private let getPlantDetailsUC: GetPlantDetailsUC
    
    init(getPlantDetailsUC: GetPlantDetailsUC) {
        self.getPlantDetailsUC = getPlantDetailsUC
    }
    
    func getPlantDetails(id: Int) {
        if getPlantDetailsUC.getPlantDetailFromStorage(id: id) != nil {
            let plant = getPlantDetailsUC.getPlantDetailFromStorage(id: id).map{ plant in
                (UIPlant(id: plant.id,
                         name: plant.common_name,
                         image: plant.image,
                         isFavorite: false,
                         origins: ["\(plant.origins.first ?? "non")", ""],
                         dimension: plant.dimension,
                         sunlights: ["\(plant.sunlights.first ?? "non")", ""],
                         cycle: plant.cycle,
                         watering: plant.watering,
                         care_level: plant.care_level,
                         medicinal: plant.medicinal
                        ))
            }
            
            self.plantDetails = plant!
        }
        else {
            Task {
                let result = await self.getPlantDetailsUC.execute(id: id)
                switch result {
                case .success(let value):
                    DispatchQueue.main.async {
                        self.plantDetails = value
                        print("test_detail_2 \(value.origins.first ?? "non")")
                    }
                case .failure(let error):
                    print("testResult error \(error)")
                }
            }
        }
    }
}
