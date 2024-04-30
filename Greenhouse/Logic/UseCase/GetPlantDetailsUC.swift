import Foundation
import Combine

class GetPlantDetailsUC {
    private let plantRepository: PlantDetailsRepository
    
    init(plantRepository: PlantDetailsRepository) {
        self.plantRepository = plantRepository
    }
    func execute(id: Int) async -> Result<UIPlant, HttpError> {
        let result = await plantRepository.getPlantDetails(id: id).flatMap { plant in
                .success(UIPlant(id: plant.id,
                                 name: plant.common_name,
                                 image: plant.default_image?.small_url,
                                 isFavorite: false,
                                 origins: plant.origins ?? ["", ""],
                                 dimension: plant.dimension, 
                                 sunlights: plant.sunlights ?? ["", ""],
                                 cycle: plant.cycle,
                                 watering: plant.watering,
                                 care_level: plant.care_level,
                                 medicinal: plant.medicinal
                                ))
        }
        return result
    }
    func getPlantDetailFromStorage(id: Int) -> FavoritePlant? {
        return plantRepository.getPlantDetailFromStorage(id: id)
    }
}
