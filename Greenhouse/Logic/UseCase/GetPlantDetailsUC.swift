import Foundation
import Combine

class GetPlantDetailsUC {
    private let plantRepository: PlantDetailsRepository
    
    init(plantRepository: PlantDetailsRepository) {
        self.plantRepository = plantRepository
    }
    func getPlantDetails(id: Int) async -> Result<UIPlant, HttpError> {
        var result = await plantRepository.getPlantDetails(id: id).flatMap { plant in
                .success(UIPlant(id: plant.id, name: plant.common_name, image: plant.default_image?.small_url, isFavorite: false))
        }
        return result
    }
}
